require 'rails_helper'

RSpec.describe Department, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:courses).dependent(:destroy) }
  end

  describe 'validations' do
    subject { build(:department) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'dependent destroy' do
    it 'destroys associated courses when department is destroyed' do
      department = create(:department)
      create(:course, department: department)
      expect { department.destroy }.to change(Course, :count).by(-1)
    end
  end
end
