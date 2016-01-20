class Course < ActiveRecord::Base
  has_many :enrollments,
    :foreign_key => :course_id,
    :primary_key => :id,
    :class_name => "Enrollment"

  has_many :users,
    :through => :enrollments,
    :source => :users

  belongs_to :prerequisite,
    :foreign_key => :prereq_id,
    :primary_key => :id,
    :class_name => 'Course'

  belongs_to :instructor,
    :foreign_key => :instructor_id,
    :primary_key => :id,
    :class_name => 'User'

  alias_method :enrolled_users, :users


end
