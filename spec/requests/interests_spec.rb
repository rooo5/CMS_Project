require 'rails_helper'

RSpec.describe "Interests", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:interest) { FactoryBot.create(:interest) }
  describe "GET /index" do
    it 'returns all the intrests present if present' do
      interest1 = create(:interest)
      interest2 = create(:interest)

      get '/interests'

      expect(response).to have_http_status(200)
    end

    it 'if there is no interest' do
      get '/interests'

      expect(response).to have_http_status(404)
    end
  end

  describe "POST /create" do
    let(:interest_attributes) { attributes_for(:interest) }

    it 'creating new interest with valid params' do
      post '/interests', params: {
        interest: interest_attributes
      }
      expect(response).to have_http_status(200)
      expect(Interest.count).to eq(1)
    end 

    it 'creating new interest wit invalid params' do
      post '/interests', params: {
        interest: interest_attributes.merge(name: '')
      }
      expect(response).to have_http_status(422)
      expect(Interest.count).to eq(0)
    end
  end
end
