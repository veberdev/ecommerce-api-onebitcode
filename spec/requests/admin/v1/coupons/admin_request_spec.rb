require 'rails_helper'

RSpec.describe "Admin::v1::Coupons", type: :request do

  context "GET /coupons" do
    let(:user) { create(:user) }
    let(:url) { "/admin/v1/coupons"}
    let!(:multiple_coupons) { create_list(:coupon, 5)}

    it "return all coupons" do
      get url, headers: auth_header(user)
      expect(body_json['coupons']).to contain_exactly *multiple_coupons.as_json(only: %i(id code status discount_value max_use due_date))
    end

    it "return success status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(200)
    end
  end

  context "POST /coupons" do
    let(:user) { create(:user) }
    let(:url) { "/admin/v1/coupons"}

    context "with invalid params" do

      context "with code param: nil" do
        let(:coupon_invalid_params) do
          {coupon: attributes_for(:coupon, code: nil )}.to_json
        end

        it "doesnt add new coupon because misses required attribute" do
          expect do
            post url, headers: auth_header(user), params: coupon_invalid_params
          end.to_not change(Coupon, :count)
        end

        it "return unprocessable entity (422) status" do
          post url, headers: auth_header(user), params: coupon_invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "return error message" do
          post url, headers: auth_header(user), params: coupon_invalid_params
          expect(body_json['errors']['fields']['code']).to eq(['não pode ficar em branco'])
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
    let(:coupon) {create(:coupon)}
    let(:url) {"/admin/v1/coupons/#{coupon.id}"}

    context "with valid params" do
      let(:new_code) { "Promo123456" }
      let(:coupon_params) do
        { coupon: attributes_for(:coupon, code: new_code)}.to_json
      end

      it "updates Coupon code" do
        patch url, headers: auth_header(user), params: coupon_params
        coupon.reload
        expect(coupon.code).to eq new_code
      end

      it "return updated category" do
        patch url, headers: auth_header(user), params: coupon_params
        coupon.reload
        expected_coupon = coupon.as_json(except: %i(created_at updated_at))
        expect(body_json['coupons']).to eq(expected_coupon)
      end

      it "return success status" do
        patch url, headers: auth_header(user), params: coupon_params
        expect(response.status).to eq(200)
      end


    end

    context "with invalid params (code: nil)" do
      let(:new_code) { "Promo123456" }
      let(:coupon_invalid_params) do
        { coupon: attributes_for(:coupon, code: nil)}.to_json
      end

      it "doesn't update a coupon" do
        patch url, headers: auth_header(user), params: coupon_invalid_params
        keys = coupon.attributes.keys
        coupon_object_in_memory = coupon
        coupon.reload
        coupon_object_in_memory = coupon_object_in_memory.attributes.select{ |key, _| keys.include? key}
        expect(coupon.attributes).to eq(coupon_object_in_memory)
      end

      it "return error message" do
        patch url, headers: auth_header(user), params: coupon_invalid_params
        expect(body_json['errors']['fields']['code']).to eq(["não pode ficar em branco"])
      end

      it "returns unprocessable_entity (422) status" do
        patch url, headers: auth_header(user), params: coupon_invalid_params
        expect(response).to have_http_status(422)
      end

    end
  end

  context "DELETE /coupons/:id" do
    let(:user) { create(:user) }
    let!(:coupon) { create(:coupon) }
    let(:url) { "/admin/v1/coupons/#{coupon.id}" }

    it "removes coupon" do
      expect do
        delete url, headers: auth_header(user)
      end.to change(Coupon, :count).by(-1)
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
