class Contact < ActiveRecord::Base
  validates :name, :email, presence: true

  belongs_to :organization
end