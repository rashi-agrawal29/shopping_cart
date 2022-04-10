class AddContactToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :contact, :integer
    add_column :orders, :payment_mode, :string
  end
end
