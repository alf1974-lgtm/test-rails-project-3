require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:department) }
    it { is_expected.to have_many(:class_sessions).dependent(:destroy) }
  end

  describe 'validations' do
    subject { build(:course) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_uniqueness_of(:code) }

    it 'is valid with a properly formatted code' do
      course = build(:course, code: 'ENG101')
      expect(course).to be_valid
    end

    it 'is invalid with a lowercase code' do
      course = build(:course, code: 'eng101')
      expect(course).not_to be_valid
      expect(course.errors[:code]).to be_present
    end

    it 'is invalid with a code that has no digits' do
      course = build(:course, code: 'ENGLISH')
      expect(course).not_to be_valid
    end

    it 'is invalid with a code that has no letters' do
      course = build(:course, code: '12345')
      expect(course).not_to be_valid
    end

    it 'accepts codes with 2-4 uppercase letters followed by 3-4 digits' do
      %w[ENG101 MATH1010 PE101 HIST2020].each do |code|
        expect(build(:course, code: code)).to be_valid, "expected #{code} to be valid"
      end
    end
  end
end
