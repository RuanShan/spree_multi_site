# This migration comes from spree_multi_site (originally 20120818031121)
class AddLoadingSample < ActiveRecord::Migration
  def up
    add_column :spree_sites, :loading_sample, :boolean, :default=>false
  end

  def down
    remove_column :spree_sites, :loading_sample
  end
end
