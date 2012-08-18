class AddHasSample < ActiveRecord::Migration
  def up
    add_column :spree_sites, :has_sample, :boolean, :default=>false
  end

  def down
    remove_column :spree_sites, :has_sample
  end
end
