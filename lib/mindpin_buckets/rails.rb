#require 'devise/rails/routes'
#require 'devise/rails/warden_compat'

module MindpinBuckets
  class Engine < ::Rails::Engine
    #initialize "mindpin_buckets.load_app_instance_data" do |app|
      #MindpinBuckets.setup do |config|
        #config.app_root = app.root
      #end
    #end

    #config.before_eager_load { |app| app.reload_routes! }

    #initializer "devise.url_helpers" do
      #MindpinBuckets.include_helpers(MindpinBuckets::Controllers)
    #end

    #initializer "devise.fix_routes_proxy_missing_respond_to_bug" do
      ## Deprecate: Remove once we move to Rails 4 only.
      #ActionDispatch::Routing::RoutesProxy.class_eval do
        #def respond_to?(method, include_private = false)
          #super || routes.url_helpers.respond_to?(method)
        #end
      #end
    #end
  end
end
