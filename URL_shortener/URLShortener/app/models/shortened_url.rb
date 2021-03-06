# == Schema Information
#
# Table name: shortened_urls
#
#  id        :bigint(8)        not null, primary key
#  long_url  :string           not null
#  short_url :string           not null
#  user_id   :integer          not null
#

class ShortenedURL < ApplicationRecord
  validates :long_url, presence: true
  validates :short_url, uniqueness: true, presence: true

  belongs_to :submitter,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User

  has_many  :visits,
    foreign_key:  :short_url_id,
    primary_key:  :id,
    class_name:   :Visit

  has_many  :visitors,
    -> { distinct },
    through:  :visits,
    source:  :visitor


  #helper method generates random string
  #method to pass in user and long_url to call create! for a new shortened_url instance

  def self.random_code
    loop do
      token = SecureRandom.urlsafe_base64
      break token unless ShortenedURL.where(short_url: token).exists?
    end
  end

  def self.create_shortened_url(user, long_url)
    token = self.random_code
    ShortenedURL.create!(long_url: long_url, short_url: token, user_id: user.id)
  end


  def num_clicks
    visits.count
  end

  def num_uniques
    visits.select(:user_id).distinct.count
  end

  def num_recent_uniques
     visits.select(:user_id).where('created_at > ?', 10.minutes.ago).distinct.count
  end


end
