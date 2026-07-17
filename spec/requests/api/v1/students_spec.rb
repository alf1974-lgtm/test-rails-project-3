require 'rails_helper'

RSpec.describe 'Api::V1::Students', type: :request do
  let(:teacher) { create(:teacher) }
  let(:student) { create(:student, advisor: teacher) }

  describe 'GET /api/v1/students/:id' do
    context 'when the student exists' do
      it "returns 200 and the student's info" do
        get "/api/v1/students/#{student.id}"

        expect(response).to have_http_status(:ok)
        json = response.parsed_body

        expect(json['id']).to eq(student.id)
        expect(json['first_name']).to eq(student.first_name)
        expect(json['last_name']).to eq(student.last_name)
        expect(json['full_name']).to eq(student.full_name)
        expect(json['email']).to eq(student.email)
        expect(json['role']).to eq('student')
        expect(json['grade']).to eq(student.grade)
      end

      it 'includes advisor info when the student has an advisor' do
        get "/api/v1/students/#{student.id}"

        json = response.parsed_body
        expect(json['advisor']).not_to be_nil
        expect(json['advisor']['id']).to eq(teacher.id)
        expect(json['advisor']['full_name']).to eq(teacher.full_name)
        expect(json['advisor']['email']).to eq(teacher.email)
      end

      it 'returns nil advisor when the student has no advisor' do
        student_no_advisor = create(:student, advisor: nil)
        get "/api/v1/students/#{student_no_advisor.id}"

        json = response.parsed_body
        expect(json['advisor']).to be_nil
      end
    end

    context 'when the user is a teacher (not a student)' do
      it 'returns 422 unprocessable_entity' do
        get "/api/v1/students/#{teacher.id}"

        expect(response).to have_http_status(:unprocessable_entity)
        json = response.parsed_body
        expect(json['error']).to eq('User is not a student')
      end
    end

    context 'when the student does not exist' do
      it 'returns 404 not found' do
        get '/api/v1/students/999999'

        expect(response).to have_http_status(:not_found)
        json = response.parsed_body
        expect(json['error']).to be_present
      end
    end
  end

  describe 'GET /api/v1/students/:id/courses' do
    context 'when the student has no enrollments' do
      it 'returns 200 with an empty enrollments array' do
        get "/api/v1/students/#{student.id}/courses"

        expect(response).to have_http_status(:ok)
        json = response.parsed_body

        expect(json['student_id']).to eq(student.id)
        expect(json['full_name']).to eq(student.full_name)
        expect(json['enrollments']).to eq([])
      end
    end

    context 'when the student has enrollments' do
      let(:department) { create(:department) }
      let(:course)     { create(:course, department: department) }
      let(:semester)   { create(:semester) }
      let(:session)    { create(:class_session, course: course, semester: semester, teacher: teacher) }

      before do
        create(:enrollment, student: student, class_session: session, grade: 'A')
      end

      it 'returns 200 with enrollment data' do
        get "/api/v1/students/#{student.id}/courses"

        expect(response).to have_http_status(:ok)
        json = response.parsed_body

        expect(json['enrollments'].length).to eq(1)
        enrollment_json = json['enrollments'].first

        expect(enrollment_json['grade']).to eq('A')
        expect(enrollment_json['class_session']['course']['name']).to eq(course.name)
        expect(enrollment_json['class_session']['course']['code']).to eq(course.code)
        expect(enrollment_json['class_session']['course']['department']).to eq(department.name)
        expect(enrollment_json['class_session']['semester']['name']).to eq(semester.name)
        expect(enrollment_json['class_session']['teacher']['full_name']).to eq(teacher.full_name)
      end

      it 'includes enrollments with no grade yet (nil grade)' do
        ungraded_session = create(:class_session, teacher: teacher)
        create(:enrollment, student: student, class_session: ungraded_session, grade: nil)

        get "/api/v1/students/#{student.id}/courses"

        json = response.parsed_body
        ungraded = json['enrollments'].find { |e| e['class_session']['id'] == ungraded_session.id }
        expect(ungraded).not_to be_nil
        expect(ungraded['grade']).to be_nil
      end

      it 'returns all enrollments across multiple semesters' do
        other_semester = create(:semester, season: 'Spring', name: 'Spring 2099', year: 2099)
        other_session  = create(:class_session, course: course, semester: other_semester, teacher: teacher)
        create(:enrollment, student: student, class_session: other_session, grade: 'B')

        get "/api/v1/students/#{student.id}/courses"

        json = response.parsed_body
        expect(json['enrollments'].length).to eq(2)
      end
    end

    context 'when the user is a teacher (not a student)' do
      it 'returns 422 unprocessable_entity' do
        get "/api/v1/students/#{teacher.id}/courses"

        expect(response).to have_http_status(:unprocessable_entity)
        json = response.parsed_body
        expect(json['error']).to eq('User is not a student')
      end
    end

    context 'when the student does not exist' do
      it 'returns 404 not found' do
        get '/api/v1/students/999999/courses'

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
