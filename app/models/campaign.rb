class Campaign < ActiveRecord::Base
  validates :title, :description, presence: true

  belongs_to :user
  belongs_to :organization

  def to_param
    "#{id}-#{title.parameterize}"
  end
end