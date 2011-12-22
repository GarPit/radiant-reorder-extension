class AddAutoOrderFieldToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :auto_order_children, :boolean, :default => false
  end

  def self.down
    remove_column :pages, :auto_order_children
  end
end
