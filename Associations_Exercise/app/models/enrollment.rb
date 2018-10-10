class Enrollment < ApplicationRecord
  # validates :student, presence: true
  # validates :course, presence: true
  #already validates below

  belongs_to :student,
    foreign_key: :student_id,
    primary_key: :id,
    class_name: :User

  belongs_to :course,
    foreign_key: :course_id,
    primary_key: :id,
    class_name: :Course
end
