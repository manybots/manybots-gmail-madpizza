module ManybotsGmailMadpizza
  class Meal < ActiveRecord::Base
    store :payload, accessors: [:price, :currency, :products, :content]
    
    def self.create_from_activity(user_id, activity)
      email_order_id = activity['object']['id'].split('/').last.to_i
      meal = self.find_or_initialize_by_user_id_and_email_order_id(user_id, email_order_id)
      if meal.new_record?
        meal = ManybotsGmailMadpizza::EmailOrder.new(user_id, activity).to_meal
        meal.email_order_id = email_order_id
        meal.save
        meal
      else
        false
      end
    end
    
    def as_object
      obj = {
        displayName: 'Meal',
        objectType: 'meal',
        id: "#{ManybotsGmailMadpizza.app.url}/meals/#{self.id}",
        url: "#{ManybotsGmailMadpizza.app.url}/meals/#{self.id}",
        price: {
          currency: self.currency,
          value: self.price
        },
        attachments: self.products.collect {|product|
          ({
            displayName: product[:name],
            objectType: 'product',
            units: product[:units],
            price: {
              currency: self.currency,
              unit: product[:price],
              total: product[:total]
            },
            id: "#{ManybotsGmailMadpizza.app.url}/products/#{Digest::MD5.hexdigest(product[:name])}",
            url: "#{ManybotsGmailMadpizza.app.url}/products/#{Digest::MD5.hexdigest(product[:name])}"
          })
        }
      }
    end
    
    def as_activity
      activity = {
        title: "ACTOR ordered a OBJECT from TARGET",
        auto_title: true,
        verb: 'order',
        published: self.ordered_at.xmlschema,
        icon: {
          url: ManybotsServer.url + ManybotsGmailMadpizza.app.app_icon_url
        },
        content: self.content
      }
      activity[:object] = self.as_object
      activity[:target] = {
        displayName: 'Madpizza',
        objectType: 'person',
        id: "http://www.madpizza.pt",
        url: "http://www.madpizza.pt"
      }
      activity[:provider] = {
        :displayName => 'Madpizza',
        :url => "http://www.madpizza.pt",
        :image => {
          :url => ManybotsServer.url + ManybotsGmailMadpizza.app.app_icon_url
        }
      }
      activity[:generator] = activity[:provider]

      activity
    end
    
  end
end
