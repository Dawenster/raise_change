class Organization < ActiveRecord::Base
  validates :name, presence: true

  has_many :contacts
  has_many :campaigns
  has_many :users, :through => :campaigns
  accepts_nested_attributes_for :campaigns
  accepts_nested_attributes_for :contacts
end