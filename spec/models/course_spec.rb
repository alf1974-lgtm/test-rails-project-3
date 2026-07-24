require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_uniqueness_of(:code) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:department) }
    it { is_expected.to have_many(:class_sessions).dependent(:destroy) }
  end
end
