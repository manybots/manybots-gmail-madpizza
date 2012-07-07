module ManybotsGmailMadpizza
  class EmailOrder
    
    def initialize(user_id, activity)
      @user_id = user_id
      
      @created_at = activity['published']
      @email_id = activity['object']['url'].split('/').last.to_i
    end
    
    def email
      @email ||= ManybotsGmail::Email.find(@email_id)
    end
    
    def body
      @body ||= email.body
    end

    def price
      @price ||= content.css('table')[2].css('tr').last.content.
        scan(/\d+/).join('.').to_f
    end
    
    def content
      @content ||= Nokogiri::HTML(body)
    end
    
    def products
      @products ||= parse_products
    end
    
    def parse_products
      table = content.css('table')[1]
      rslt=[]
      table.css('tr').to_a.in_groups_of(3) do |line|
        rslt.push parse_product_line(line)
      end
      rslt
    end
    
    def to_meal
      @meal = ManybotsGmailMadpizza::Meal.new
      @meal.user_id = @user_id
      @meal.ordered_at = @created_at
      @meal.price = self.price
      @meal.currency = 'EUR'
      @meal.products = self.products
      # @meal.content = self.body.to_s
      @meal
    end
    
    private
    
    def parse_product_line(line)
      product = line[0].css('td')
      details = product[1..-1]
      ingredients = line[1]
      rslt = {
        image: product[0].css('img').first.attr('src'),
        name: details[0].children.first.content.strip,
        category: details[0].children.last.content.strip,
        size: details[1].content.strip,
        units: details[2].content.strip,
        total: parse_float(details[3].content.strip),
        ingredients: ingredients.content.strip.split(', '),
      }
      rslt.merge ({
        price: (rslt[:total] / rslt[:units].to_f)
      })
    end
    
    def parse_float(str)
      str.scan(/\d+/).join('.').to_f
    end
    
  end
end
