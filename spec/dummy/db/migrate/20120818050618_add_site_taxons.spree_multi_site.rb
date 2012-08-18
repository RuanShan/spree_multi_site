# This migration comes from spree_multi_site (originally 20120813135747)
class AddSiteTaxons < ActiveRecord::Migration
  def up
    table_name = Spree::Taxon.connection.table_exists?(:taxons) ? :taxons : :spree_taxons
    add_column table_name, :site_id, :integer
    table_name = Spree::TaxCategory.connection.table_exists?(:tax_categories) ? :tax_categories : :spree_tax_categories
    add_column table_name, :site_id, :integer
    table_name = Spree::ShippingCategory.connection.table_exists?(:shipping_categories) ? :shipping_categories : :spree_shipping_categories
    add_column table_name, :site_id, :integer
    table_name = Spree::Prototype.connection.table_exists?(:prototypes) ? :prototypes : :spree_prototypes
    add_column table_name, :site_id, :integer
    table_name = Spree::Property.connection.table_exists?(:properties) ? :properties : :spree_properties
    add_column table_name, :site_id, :integer
    table_name = Spree::OptionType.connection.table_exists?(:option_types) ? :option_types : :spree_option_types
    add_column table_name, :site_id, :integer
  end

  def down
    remove_column Spree::Taxon.table_name, :site_id, :integer
    remove_column Spree::TaxCategory.table_name, :site_id
    remove_column Spree::ShippingCategory.table_name, :site_id
    remove_column Spree::Prototype.table_name, :site_id
    remove_column Spree::Property.table_name, :site_id
    remove_column Spree::OptionType.table_name, :site_id
  end

end
