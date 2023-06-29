require 'rails_helper'

RSpec.describe Qualification, type: :model do
  describe 'Checks the valid Qualification' do
    it 'checks the presence of valid name' do
      qualification = create(:qualification)
      expect(qualification).to be_valid
    end

    it 'checks the presence of name' do
      qualification = create(:qualification, name: nil)
      expect(qualification).not_to be_valid
      expect(response.errors[:name]).to include("can't be blank")
    end
  end
end
