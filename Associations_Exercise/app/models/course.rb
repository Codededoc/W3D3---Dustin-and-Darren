class Course < ApplicationRecord
  
  has_many :enrollments,
    foreign_key: :course_id,
    primary_key: :id,
    class_name: :Enrollment

  has_many :enrolled_students,
    through: :enrollments,
    source: :student # users?

  has_many :prerequisite, #self-referencing for pre-reqs
    foreign_key: :prereq_id,
    primary_key: :id,
    class_name: :Course

  has_many :post_req_course, #self-referencing to course
    foreign_key: :prereq_id,
    primary_key: :id,
    class_name: :Course

  belongs_to :instructor,
    foreign_key: :instructor_id,
    primary_key: :id,
    class_name: :User
end
