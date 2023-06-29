require 'rails_helper'

RSpec.describe "Qualification", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:qualification) { FactoryBot.create(:qualification) }
  describe "GET /index" do
    it 'returns all the qualifications present if present' do
      qualification1 = create(:qualification)
      qualification2 = create(:qualification)

      get '/qualifications'

      expect(response).to have_http_status(200)
    end

    it 'if there is no qualifications' do
      get '/qualifications'

      expect(response).to have_http_status(404)
    end
  end

  describe "POST /create" do
    let(:qualification_attributes) { attributes_for(:qualification) }

    it 'creating new qualification with valid params' do
      post '/qualifications', params: {
        qualification: qualification_attributes
      }
      expect(response).to have_http_status(200)
      expect(Qualification.count).to eq(1)
    end 

    it 'creating new qualification with invalid params' do
      post '/qualifications', params: {
        qualification: qualification_attributes.merge(name: '')
      }
      expect(response).to have_http_status(422)
      expect(Qualification.count).to eq(0)
    end
  end
end
