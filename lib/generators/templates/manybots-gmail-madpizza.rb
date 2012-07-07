# Configure the Manybots Gmail Madpizza app

ManybotsGmailMadpizza.setup do |config|
  # App nickname
  config.nickname = 'manybots-gmail-madpizza'
  
end

app = ClientApplication.find_or_initialize_by_nickname ManybotsGmailMadpizza.nickname
if app.new_record?
  app.app_type = "Agent"
  app.name = "Madpizza Agent"
  app.description = "Convert order confirmation emails from Madpizza into real activities."
  app.url = ManybotsServer.url + '/manybots-gmail-madpizza'
  app.app_icon_url = "/assets/manybots-gmail-madpizza/icon.png"
  app.developer_name = "Manybots"
  app.developer_url = "https://www.manybots.com"
  app.category = "Lifestyle"
  app.is_public = true
  app.save
end
ManybotsGmailMadpizza.app = app
