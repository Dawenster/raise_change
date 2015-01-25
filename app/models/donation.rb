class Donation < ActiveRecord::Base
  validates :amount, :max, presence: true

  belongs_to :user
  belongs_to :campaign

  def amount_in_dollars
    amount.to_f / 100
  end
end