# order model by alphabet

Spree::Asset.class_eval do
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

Spree::OptionType.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end    

Spree::Order.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end

Spree::LineItem.class_eval do
  default_scope :joins => :order
  default_scope {where("spree_orders.site_id=?", Spree::Site.current.id)}
end

Spree::Prototype.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end    

Spree::Preference.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end    

Spree::PaymentMethod.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end    

Spree::Product.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end

Spree::Property.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end

Spree::ShippingCategory.class_eval do
  has_many :shipping_methods,:dependent=>:destroy #override to add destroy
end

Spree::Taxonomy.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end


Spree::Taxon.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end

Spree::TaxCategory.class_eval do
  extend AttributeValidatorCleaner
  
  belongs_to :site

  default_scope  { where(:site_id =>  Spree::Site.current.id) }

  remove_attribute_validator(:name)
  # Add new validates_uniqueness_of with correct scope
  validates :name, :uniqueness => { :scope => [:site_id,:deleted_at] }

end

Spree::TaxRate.class_eval do
  default_scope :joins => :tax_category
  default_scope {where("spree_tax_categories.site_id=?", Spree::Site.current.id)}
end


Spree::User.class_eval do
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
end

Spree::Zone.class_eval do
  extend AttributeValidatorCleaner  
  belongs_to :site
  default_scope  { where(:site_id =>  Spree::Site.current.id) }
  
  remove_attribute_validator(:name)
  # Add new validates_uniqueness_of with correct scope
  validates :name, :presence => true, :uniqueness => { :scope => [:site_id] }
end    


