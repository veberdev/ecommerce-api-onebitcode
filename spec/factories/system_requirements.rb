FactoryBot.define do
  factory :system_requirement do
    sequence(:name) { |n| "system requirements #{n}"}
    operational_system { Faker::Computer.platform }
    storage { "10gb" }
    processor { "amd ryzen 8" }
    memory { "8gb" }
    video_board { "geforce 1050 ti" }
  end
end
