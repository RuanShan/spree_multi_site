class AddSiteLayout < ActiveRecord::Migration
  def self.up
    add_column :spree_sites, :layout, :string
  end

  def self.down
    remove_column :spree_sites, :layout
  end
end