class AddOrderIdToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :order_id, :string
    add_column :line_items, :integer, :string
  end
end
