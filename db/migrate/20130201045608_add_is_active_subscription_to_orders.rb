class AddIsActiveSubscriptionToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :is_active_subscription, :boolean, :default => false
  end
end
