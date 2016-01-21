# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  email      :string           not null
#

class User < ActiveRecord::Base
  validates :email, :presence => true, :uniqueness => true

  has_many :shortened_urls,
    :class_name => 'ShortenedUrl',
    :foreign_key => :submitter_id,
    :primary_key => :id

  has_many :visits,
    :class_name => 'Visit',
    :foreign_key => :user_id,
    :primary_key => :id

  has_many :visited_urls,
    Proc.new { distinct },
    :through => :visits,
    :source => :shortened_url


  def self.create_user(email)
    User.create(:email => email)
  end

end
