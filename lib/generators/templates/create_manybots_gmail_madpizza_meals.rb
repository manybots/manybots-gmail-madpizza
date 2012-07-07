class CreateManybotsGmailMadpizzaMeals < ActiveRecord::Migration
  def change
    create_table :manybots_gmail_madpizza_meals do |t|
      t.integer :user_id
      t.integer :email_order_id
      t.datetime :ordered_at
      t.text :payload

      t.timestamps
    end
  end
end
