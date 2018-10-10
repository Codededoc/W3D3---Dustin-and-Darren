# == Schema Information
#
# Table name: visits
#
#  id           :bigint(8)        not null, primary key
#  user_id      :integer          not null
#  short_url_id :integer          not null
#

class Visit < ApplicationRecord

  # validates  :user_id, :short_urls, presence: true

  has_many :visitors,
    foreign_key:  :user_id,
    primary_key:  :id,
    class_name:   :User

  has_many  :short_urls,
    foreign_key:  :short_url_id,
    primary_key:  :id,
    class_name:   :ShortenedURL

  def self.record_visit!(user, shortened_url)
    Visit.create!(user_id: user.id, short_url_id: shortened_url.id)
  end


end
