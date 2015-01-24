class Donation < ActiveRecord::Base
  validates :amount, :max, presence: true

  belongs_to :user
  belongs_to :campaign
end