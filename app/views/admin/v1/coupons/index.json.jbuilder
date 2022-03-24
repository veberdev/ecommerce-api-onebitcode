json.coupons do
  json.array! @coupons, :id, :code, :status, :discount_value, :max_use, :due_date
end