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

  belongs_to :user,
    :class_name => 'User',
    :foreign_key => :submitter_id,
    :primary_key => :id

  has_many :visits,
    :class_name => 'Visit',
    :foreign_key => :shortened_url_id,
    :primary_key => :id

  has_many :visitors,
    Proc.new { distinct },
    :through => :visits,
    :source => :user,
    :class_name => "User"

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
    ShortenedUrl.create!(:short_url => rand_code,
      :long_url => long_url, :submitter_id => user.id)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    visitors = self.visitors
    visitors.where('visits.updated_at > ?', 1000.minutes.ago)
  end


  def self.find_by_short_url(short_url)
    self.where(:short_url => short_url).first.long_url

  end
end
