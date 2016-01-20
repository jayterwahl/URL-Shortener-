# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  created_at   :datetime
#  updated_at   :datetime
#  short_url    :string           not null
#  long_url     :string           not null
#  submitter_id :integer          not null
#
require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :presence => true, :uniqueness => true
  validates :long_url, :presence => true, :uniqueness => true
  validates :submitter_id, :presence => true

  belongs_to :users,
    :class_name => 'User',
    :foreign_key => :submitter_id,
    :primary_key => :id

  def self.random_code
    exists = true
    while exists
      code = SecureRandom.urlsafe_base64
      exists = ShortenedUrl.exists?(:short_url => code)
    end
    code
  end

  def self.create_for_user_and_long_url!(user,long_url)
    rand_code = ShortenedUrl.random_code
    shortened_url = ShortenedUrl.new(:short_url => rand_code,
      :long_url => long_url, :submitter_id => user.id)
    shortened_url.save
  end
end
