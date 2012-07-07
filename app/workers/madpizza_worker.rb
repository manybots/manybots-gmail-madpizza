require 'manybots-api-client'

class MadpizzaWorker
  @queue = :agents
  
  attr_accessor :user, :manybots_client
  
  def initialize(user_id)
    @user = User.find(user_id)
    @manybots_client = Manybots::Client.new(@user.authentication_token)
  end
  
  def items
    @items ||= self.manybots_client.activities(
      {displayName: 'madpizza', verb: 'receive', object: 'email'}, 
      1, 100
    )['data']['items'] rescue(nil)
  end
  
  def post_to_manybots!(order)
    self.manybots_client.create_activity(order)
  end
  
  def self.perform(user_id)
    worker = self.new(user_id)
    return "no items" if worker.items.nil? or worker.items.empty?
    worker.items.each do |activity|
      meal = ManybotsGmailMadpizza::Meal.create_from_activity(user_id, activity)
      worker.post_to_manybots!(meal.as_activity) if meal
    end
  end
end

