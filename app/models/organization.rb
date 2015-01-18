class Organization < ActiveRecord::Base
  has_many :contacts
  has_many :campaigns
  has_many :users, :through => :campaigns
end