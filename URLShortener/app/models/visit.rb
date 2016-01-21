# == Schema Information
#
# Table name: visits
#
#  id               :integer          not null, primary key
#  shortened_url_id :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Visit < ActiveRecord::Base
  validates :user_id, :presence => true
  validates :shortened_url_id, :presence => true

  belongs_to :shortened_url,
    :foreign_key => :shortened_url_id,
    :primary_key => :id,
    :class_name => 'ShortenedUrl'

  belongs_to :user,
    :foreign_key => :user_id,
    :primary_key => :id,
    :class_name => 'User'

  def self.record_visit!(user, shortened_url)
    Visit.create(:shortened_url_id => shortened_url.id, :user_id => user.id)
  end
end
