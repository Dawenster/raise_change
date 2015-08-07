require 'uri'

class Organization < ActiveRecord::Base
  validates :name, presence: true
  validate :valid_url

  has_many :contacts
  has_many :campaigns
  has_many :users, :through => :campaigns
  has_many :org_admins, class_name: "OrgAdmin", foreign_key: "organization_id", dependent: :destroy
  has_many :admin_users, through: :org_admins, source: :user
  has_many :journal_entries, :through => :campaigns

  accepts_nested_attributes_for :campaigns
  accepts_nested_attributes_for :contacts, :reject_if => proc { |contact| contact['name'].blank? && contact['email'].blank? }

  before_save :create_slug

  def create_slug
    self.slug = self.to_slug
  end

  def to_slug
    self.name.parameterize
  end

  def self.find_by_slug_or_create(name)
    return Organization.find_by_slug(name.parameterize) || Organization.create(:name => name.strip)
  end

  def valid_url
    return true if website.blank?
    uri = URI.parse(website)
    unless uri.kind_of?(URI::HTTP)
      errors.add(:website, "must be blank or a valid url (with the http)")
    end
  rescue URI::InvalidURIError
    errors.add(:website, "must be blank or a valid url (with the http)")
  end

  def has_site?
    self.id && self.website.blank? ? 'noSite' : 'hasSite'
  end

  def has_contact?
    self.id && self.contacts.first.id.nil? ? 'noContact' : 'hasContact'
  end

  def all_hours_are_verified?
    return self.journal_entries.where(:verified => false).empty?
  end
end