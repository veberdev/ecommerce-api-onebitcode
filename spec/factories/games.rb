FactoryBot.define do
  factory :game do
    mode { %i(pvp pve both).sample }     # mode { [:pvp, :pve, :both].sample }
    release_date { "2022-03-10 11:48:53" }
    developer { Faker::Company.name }
    system_requirement
  end
end
