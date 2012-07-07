require 'rails/generators'
require 'rails/generators/base'
require 'rails/generators/migration'

module ManybotsGmailMadpizza
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      
      source_root File.expand_path("../../templates", __FILE__)
      
      class_option :routes, :desc => "Generate routes", :type => :boolean, :default => true
      class_option :migrations, :desc => "Generate migrations", :type => :boolean, :default => true
      
      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end
      
      desc 'Mounts Manybots Gmail Madpizza at "/manybots-gmail-madpizza"'
      def add_manybots_gmail_madpizza_routes
        route 'mount ManybotsGmailMadpizza::Engine => "/manybots-gmail-madpizza"' if options.routes?
      end
      
      desc "Copies Manybots Gmail Madpizza migrations"
      def create_model_file
        migration_template "create_manybots_gmail_madpizza_meals.rb", "db/migrate/create_manybots_gmail_madpizza_meals.manybots_gmail_madpizza.rb"
      end
      
      desc "Creates a ManybotsGmail initializer"
      def copy_initializer
        template "manybots-gmail-madpizza.rb", "config/initializers/manybots-gmail-madpizza.rb"
      end
      
      def show_readme
        readme "README" if behavior == :invoke
      end
      
    end
  end
end
