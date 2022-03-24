json.coupons do
  json.(@coupon, :id, :code, :status, :discount_value, :max_use, :due_date)
end