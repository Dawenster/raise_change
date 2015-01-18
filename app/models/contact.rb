class Contact < ActiveRecord::Base
  validates :name, :email, presence: true
  validates :email, :format => { :with => /^\s*(([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})[\s\/,;]*)+$/i, :message => "is not a valid email", :multiline => true }

  belongs_to :organization
end