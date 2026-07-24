require 'rails_helper'

RSpec.describe Api::V1::StudentsController, type: :controller do
  describe 'GET #show' do
    let(:student) { create(:user, :student) }

    it 'returns the student information' do
      get :show, params: { id: student.id }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['id']).to eq(student.id)
      expect(json['name']).to eq(student.name)
      expect(json['email']).to eq(student.email)
      expect(json['role']).to eq('student')
    end

    it 'returns 404 for non-existent student' do
      get :show, params: { id: 99999 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET #me' do
    let(:student) { create(:user, :student) }

    it 'returns the current student information' do
      get :me, params: { student_id: student.id }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['id']).to eq(student.id)
      expect(json['name']).to eq(student.name)
      expect(json['email']).to eq(student.email)
      expect(json['role']).to eq('student')
    end
  end

  describe 'GET #courses' do
    let(:student) { create(:user, :student) }
    let(:department) { create(:department) }
    let(:course1) { create(:course, department: department) }
    let(:course2) { create(:course, department: department) }
    let(:semester) { create(:semester) }
    let(:teacher) { create(:user, :teacher) }

    before do
      class_session1 = create(:class_session, course: course1, semester: semester, teacher: teacher)
      class_session2 = create(:class_session, course: course2, semester: semester, teacher: teacher)
      create(:enrollment, user: student, class_session: class_session1)
      create(:enrollment, user: student, class_session: class_session2)
    end

    it 'returns all courses for the student' do
      get :courses, params: { student_id: student.id }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json.map { |c| c['id'] }).to include(course1.id, course2.id)
    end

    it 'returns course details including department' do
      get :courses, params: { student_id: student.id }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      course_json = json.first
      expect(course_json).to have_key('id')
      expect(course_json).to have_key('name')
      expect(course_json).to have_key('code')
      expect(course_json).to have_key('department')
      expect(course_json['department']).to have_key('id')
      expect(course_json['department']).to have_key('name')
    end

    it 'returns empty array if student has no courses' do
      new_student = create(:user, :student)
      get :courses, params: { student_id: new_student.id }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json).to eq([])
    end
  end
end
