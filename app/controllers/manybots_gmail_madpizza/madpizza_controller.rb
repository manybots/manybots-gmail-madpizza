module ManybotsGmailMadpizza
  class MadpizzaController < ApplicationController
    before_filter :authenticate_user!
    
    def show
      load_schedule(current_user)
    end
    
    def toggle
      load_schedule(current_user)
      if @schedule == true
        ManybotsServer.queue.remove_schedule @schedule_name
        redirect_to root_path, :notice => 'Madpizza agent stopped.'
      else
        ManybotsServer.queue.add_schedule @schedule_name, {
          :every => '24h', 
          :first_at => Time.now + 2.seconds,
          :class => "MadpizzaWorker",
          :queue => "agents",
          :args => current_user.id,
          :description => "This job will fetch emails from Madpizza daily and convert them to meal orders for user ##{current_user.id}"
        }
        
        redirect_to root_path, :notice => 'Madpizza agent started.'
      end
    end
    
    private
      def load_schedule(user)
        schedules = ManybotsServer.queue.get_schedules
        @schedule_name = "import_manybots_gmail_madpizza_#{current_user.id}"
        @schedule = schedules.keys.include?(@schedule_name) rescue(false)
      end
  end
end
