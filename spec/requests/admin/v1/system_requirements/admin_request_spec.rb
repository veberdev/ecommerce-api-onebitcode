require 'rails_helper'

RSpec.describe "Admin::v1::SystemRequirements", type: :request do

  context "GET /system_requirements" do
    let(:user) { create(:user) }
    let(:url) { "/admin/v1/system_requirements"}
    let!(:multiple_system_requirements) { create_list(:system_requirement, 5)}

    it "return all system_requirements" do
      get url, headers: auth_header(user)
      expect(body_json['system_requirements']).to contain_exactly *multiple_system_requirements.as_json(except: %i(created_at updated_at))
    end

    it "return success status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(200)
    end
  end

  context "POST /coupons" do
    let(:user) { create(:user) }
    let(:url) { "/admin/v1/system_requirements"}

    context "with invalid params" do

      context "with name param: nil" do
        let(:system_requirements_invalid_params) do
          {system_requirement: attributes_for(:system_requirement, name: nil )}.to_json
        end

        it "doesnt add new system_requirements because misses required attribute (name)" do
          expect do
            post url, headers: auth_header(user), params: system_requirements_invalid_params
          end.to_not change(SystemRequirement, :count)
        end

        it "return unprocessable entity (422) status" do
          post url, headers: auth_header(user), params: system_requirements_invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "return error message" do
          post url, headers: auth_header(user), params: system_requirements_invalid_params
          expect(body_json['errors']['fields']['name']).to eq(['não pode ficar em branco'])
        end

      end
    end

    context "with valid params" do
      let(:valid_params) { { coupon: attributes_for(:coupon) }.to_json  }

      it "adds a new coupon" do
        expect do
          post url, headers: auth_header(user), params: valid_params
        end.to change(Coupon, :count).by(1)
      end

      it "returns last added Coupon" do
        post url, headers: auth_header(user), params: valid_params
        last_coupon = Coupon.last.id
        expect(body_json['coupons']['id']).to eq(last_coupon)
      end

      it "return success status" do
        post url, headers: auth_header(user), params: valid_params
        expect(response).to have_http_status(200) # could use also: expect(response.status).to eq(200)
      end

    end
  end

  context "PATCH /coupons/:id"  do
    let(:user) {create(:user)}
    let(:system_requirement) {create(:system_requirement)}
    let(:url) {"/admin/v1/system_requirements/#{system_requirement.id}"}

    context "with valid params" do
      let(:new_name) { "SystemRequirementName" }
      let(:system_requirement_params) do
        { system_requirement: attributes_for(:system_requirement, name: new_name)}.to_json
      end

      it "updates Coupon code" do
        patch url, headers: auth_header(user), params: system_requirement_params
        system_requirement.reload
        expect(system_requirement.name).to eq new_name
      end

      it "return updated category" do
        patch url, headers: auth_header(user), params: system_requirement_params
        system_requirement.reload
        expected_system_requirement = system_requirement.as_json(except: %i(created_at updated_at))
        expect(body_json['system_requirements']).to eq(expected_system_requirement)
      end

      it "return success status" do
        patch url, headers: auth_header(user), params: system_requirement_params
        expect(response.status).to eq(200)
      end
    end

    context "with invalid params (name: nil)" do
      let(:new_name) { "Promo123456" }
      let(:system_requirement_invalid_params) do
        { system_requirement: attributes_for(:system_requirement, name: nil)}.to_json
      end

      it "doesn't update a coupon" do
        patch url, headers: auth_header(user), params: system_requirement_invalid_params
        keys = system_requirement.attributes.keys
        system_requirement_object_in_memory = system_requirement
        system_requirement.reload
        system_requirement_object_in_memory = system_requirement_object_in_memory.attributes.select{ |key, _| keys.include? key}
        expect(system_requirement.attributes).to eq(system_requirement_object_in_memory)
      end

      it "return error message" do
        patch url, headers: auth_header(user), params: system_requirement_invalid_params
        expect(body_json['errors']['fields']['name']).to eq(["não pode ficar em branco"])
      end

      it "returns unprocessable_entity (422) status" do
        patch url, headers: auth_header(user), params: system_requirement_invalid_params
        expect(response).to have_http_status(422)
      end

    end
  end

  context "DELETE /coupons/:id" do
    let(:user) { create(:user) }
    let!(:system_requirement) { create(:system_requirement) }
    let(:url) { "/admin/v1/system_requirements/#{system_requirement.id}" }

    it "removes system_requirements" do
      expect do
        delete url, headers: auth_header(user)
      end.to change(SystemRequirement, :count).by(-1)
    end

    it "returns no content status (204)" do
      delete url, headers: auth_header(user)
      expect(response.status).to eq(204)
    end

    it "doesn't return any body content" do
      delete url, headers: auth_header(user)
      expect(body_json).to eq({})
    end

  end
end
