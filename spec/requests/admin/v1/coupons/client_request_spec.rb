require 'rails_helper'

RSpec.describe "Admin V1 Coupons as :client", type: :request do

  context "GET /coupons" do
    let(:user) {create(:user, profile: :client)}
    let(:url) {"/admin/v1/coupons"}

    before(:each) {get url, headers: auth_header(user)}

    include_examples "forbidden access"

  end

  context "POST /coupons" do
    let(:user) {create(:user, profile: :client)}
    let(:url) {"/admin/v1/coupons"}
    let(:coupons) {create_list(:coupon, 5)}

    before(:each) {post url, headers: auth_header(user) }
    include_examples "forbidden access"
  end

  context "PATCH /coupons" do
    let(:user) {create(:user, profile: :client)}
    let(:coupon) {create(:coupon)}
    let(:url) {"/admin/v1/coupons/#{coupon.id}"}

    before(:each) {patch url, headers: auth_header(user) }
    include_examples "forbidden access"

  end

  context "DELETE /coupon" do
    let(:user) {create(:user, profile: :client)}
    let(:coupon) {create(:coupon)}
    let(:url) {"/admin/v1/coupons/#{coupon.id}"}

    before(:each) {delete url, headers: auth_header(user) }
    include_examples "forbidden access"
  end
end
