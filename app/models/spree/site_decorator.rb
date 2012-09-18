# admin.tabs.add "Multi Site", "/admin/multi_site", :after => "Layouts", :visibility => [:all]

Spree::Product.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end

Spree::Taxonomy.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end

Spree::Order.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end

Spree::User.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end

Spree::Taxon.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end
Spree::TaxCategory.class_eval do
  belongs_to :site

  default_scope  { where(:site_id =>  Spree::Site.current.id) }
  #refer to http://stackoverflow.com/questions/7545938/how-to-remove-validation-using-instance-eval-clause-in-rails
  #remove original defined validator first.
  _validators.reject!{ |key, _| key == :name }

  _validate_callbacks.reject! do |callback|
    if callback.raw_filter.respond_to? :attributes
      #callback.raw_filter maybe symbol, ex. :validate_associated_records_for_tax_rates:Symbol 
      callback.raw_filter.attributes == [:name]
    end
  end


  # Add new validates_uniqueness_of with correct scope
  validates :name, :uniqueness => { :scope => [:site_id,:deleted_at] }

end
Spree::Property.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end
Spree::PaymentMethod.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end    
Spree::OptionType.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end    
Spree::Prototype.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end    

Spree::Configuration.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end    
Spree::LogEntry.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end    
Spree::Preference.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end    
Spree::Zone.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end    


Spree::ShippingCategory.class_eval do
  has_many :shipping_methods,:dependent=>:destroy #override to add destroy
end


