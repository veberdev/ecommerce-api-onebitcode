require 'rails_helper'

RSpec.describe Category, type: :model do
  # sem o shoulda_matchers: it { should validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:name)}
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

  it { is_expected.to have_many(:product_categories).dependent(:destroy)}
  it { is_expected.to have_many(:products).through(:product_categories)}

  it_behaves_like "name searchable concern", :category

end
