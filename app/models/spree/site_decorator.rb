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
end
  
Spree::ShippingCategory.class_eval do
  has_many :shipping_methods,:dependent=>:destroy #override to add destroy
end
