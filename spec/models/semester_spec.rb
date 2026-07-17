require 'rails_helper'

RSpec.describe Semester, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:class_sessions).dependent(:destroy) }
  end

  describe 'validations' do
    subject { build(:semester) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:season) }
    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_inclusion_of(:season).in_array(%w[Fall Spring]) }

    it 'is invalid with a season outside Fall/Spring' do
      semester = build(:semester, season: 'Summer')
      expect(semester).not_to be_valid
      expect(semester.errors[:season]).to be_present
    end

    it 'is invalid with a year of 2000 or earlier' do
      semester = build(:semester, year: 2000)
      expect(semester).not_to be_valid
    end

    it 'is valid with year 2026' do
      semester = build(:semester, year: 2026)
      expect(semester).to be_valid
    end

    context 'uniqueness of season scoped to year' do
      before { create(:semester, season: 'Fall', year: 2030, name: 'Fall 2030') }

      it 'rejects a duplicate season+year combination' do
        duplicate = build(:semester, season: 'Fall', year: 2030, name: 'Fall 2030 Dup')
        expect(duplicate).not_to be_valid
        expect(duplicate.errors[:season]).to be_present
      end

      it 'allows a different season in the same year' do
        spring = build(:semester, season: 'Spring', year: 2030, name: 'Spring 2030')
        expect(spring).to be_valid
      end
    end
  end
end
