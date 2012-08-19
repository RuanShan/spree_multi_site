# This migration comes from spree_multi_site (originally 20120420163828)
class AddSiteOrders < ActiveRecord::Migration
  def self.up
    #for history reason, 
    #spree's table have no prefix 'spree_' at beginning,
    #later migration NamespaceTopLevelModels add prefix 'spree_'
    #so here table_exists?(:taxonomies) is accurate name.
    table_name = Spree::Taxonomy.connection.table_exists?(:taxonomies) ? :taxonomies : :spree_taxonomies
    add_column table_name, :site_id, :integer
    table_name = Spree::Order.connection.table_exists?(:orders) ? :orders : :spree_orders
    add_column table_name, :site_id, :integer
    table_name = Spree::User.connection.table_exists?(:users) ? :users : :spree_users
    add_column table_name, :site_id, :integer
    table_name = Spree::Product.connection.table_exists?(:products) ? :products : :spree_products
    add_column table_name, :site_id, :integer
  end

  def self.down
    remove_column Spree::Taxonomy.table_name, :site_id
    remove_column Spree::Order.table_name, :site_id
    remove_column Spree::User.table_name, :site_id
    remove_column Spree::Product.table_name, :site_id
  end
end