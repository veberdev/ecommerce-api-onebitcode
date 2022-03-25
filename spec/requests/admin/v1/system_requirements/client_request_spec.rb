require 'rails_helper'

RSpec.describe "Admin V1 SystemRequirement as :client", type: :request do

  context "GET /system_requirements" do
    let(:user) {create(:user, profile: :client)}
    let(:url) {"/admin/v1/system_requirements"}

    before(:each) {get url, headers: auth_header(user)}

    include_examples "forbidden access"

  end

  context "POST /system_requirements" do
    let(:user) {create(:user, profile: :client)}
    let(:url) {"/admin/v1/system_requirements"}
    let(:system_requirements) {create_list(:system_requirement, 5)}

    before(:each) {post url, headers: auth_header(user) }
    include_examples "forbidden access"
  end

  context "PATCH /coupons" do
    let(:user) {create(:user, profile: :client)}
    let(:system_requirement) {create(:system_requirement)}
    let(:url) {"/admin/v1/coupons/#{system_requirement.id}"}

    before(:each) {patch url, headers: auth_header(user) }
    include_examples "forbidden access"

  end

  context "DELETE /system_requirement" do
    let(:user) {create(:user, profile: :client)}
    let(:system_requirement) {create(:system_requirement)}
    let(:url) {"/admin/v1/coupons/#{system_requirement.id}"}

    before(:each) {delete url, headers: auth_header(user) }
    include_examples "forbidden access"
  end
end
