class JournalEntry < ActiveRecord::Base
  validates :dates, :hours, presence: true

  belongs_to :user
  belongs_to :campaign
end