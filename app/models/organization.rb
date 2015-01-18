class Organization < ActiveRecord::Base
  has_many :campaigns
  has_many :contacts
  has_and_belongs_to_many :users
end