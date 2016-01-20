class Enrollment < ActiveRecord::Base
  belongs_to :courses,
    :foreign_key => :course_id,
    :primary_key => :id,
    :class_name => "Course"


  belongs_to :users,
    :foreign_key => :student_id,
    :primary_key => :id,
    :class_name => "User"

end
