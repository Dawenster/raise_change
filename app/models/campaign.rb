class Campaign < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  def to_param
    "#{id}-#{title.parameterize}"
  end
end