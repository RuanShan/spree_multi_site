module SpreeMultiSite
  class Engine < Rails::Engine
    engine_name 'spree_multi_site'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "spree.multisite.environment", :before => :load_config_initializers do |app|
      SpreeMultiSite::Config = Spree::MultiSiteConfiguration.new
    end
      
    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
    #spree_abc require #{config.root}/app/mailers
    config.autoload_paths += %W(#{config.root}/app/models/spree #{config.root}/app/jobs)
    config.to_prepare &method(:activate).to_proc
    
    
  end
end
