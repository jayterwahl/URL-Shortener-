class User < ActiveRecord::Base
  has_many :enrollments,
    :foreign_key => :student_id,
    :primary_key => :id,
    :class_name => "Enrollment"

  has_many :courses,
    :through => :enrollments,
    :source => :courses

  def enrolled_courses
    self.courses
  end
end
