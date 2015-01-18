class Campaign < ActiveRecord::Base
  belongs_to :user

  def to_param
    "#{id}-#{title.parameterize}"
  end
end