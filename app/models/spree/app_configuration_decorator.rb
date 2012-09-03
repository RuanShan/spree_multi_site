Spree::AppConfiguration.class_eval do
  preference :data_dir, :string, :default => File.join(SpreeMultiSite::Engine.root,'db')
  
end