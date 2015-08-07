class Donation < ActiveRecord::Base
  validates :amount, :max, presence: true

  belongs_to :user
  belongs_to :campaign

  def amount_in_dollars
    amount.to_f / 100
  end

  def details_for_popover_as_string(show_max)
    str = "<div>#{ActionController::Base.helpers.number_to_currency(self.amount.to_f / 100)} per hour</div>"
    str += "<div>#{ActionController::Base.helpers.number_to_currency(self.max.to_f / 100)} max per quarter</div>" if show_max
    return str
  end
end