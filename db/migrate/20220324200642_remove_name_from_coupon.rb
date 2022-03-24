class RemoveNameFromCoupon < ActiveRecord::Migration[6.0]
  def change
    remove_column :coupons, :name, :string
  end
end
