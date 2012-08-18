class AddLoadingSample < ActiveRecord::Migration
  def up
    add_column :spree_sites, :loading_sample, :boolean, :default=>false
  end

  def down
    remove_column :spree_sites, :loading_sample
  end
end
