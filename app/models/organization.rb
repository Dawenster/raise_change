require 'uri'

class Organization < ActiveRecord::Base
  validates :name, presence: true
  validate :valid_url

  has_many :contacts
  has_many :campaigns
  has_many :users, :through => :campaigns
  accepts_nested_attributes_for :campaigns
  accepts_nested_attributes_for :contacts, :reject_if => :all_blank

  def valid_url
    return true if website.blank?
    uri = URI.parse(website)
    unless uri.kind_of?(URI::HTTP)
      errors.add(:website, "must be blank or a valid url (with the http)")
    end
  rescue URI::InvalidURIError
    errors.add(:website, "must be blank or a valid url (with the http)")
  end
end