class Campaign < ActiveRecord::Base
  validates :title, :description, presence: true

  belongs_to :user
  belongs_to :organization
  has_many :donations
  has_many :journal_entries

  s3_credentials_hash = {
    :access_key_id => ENV['AWS_ACCESS_KEY'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }

  has_attached_file :image, 
                    :styles => { :thumb => "300x225#", :display => "720x540#" },
                    :s3_credentials => s3_credentials_hash,
                    :bucket => ENV['AWS_BUCKET'],
                    :default_url => "https://s3-us-west-2.amazonaws.com/timeauction/missing-auction-thumb.png",
                    :s3_protocol => :https

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def donations_per_hour_in_cents
    self.donations.sum(:amount)
  end

  def donations_per_hour
    donations_per_hour_in_cents.to_f / 100
  end

  def num_sponsors
    self.donations.select(:user_id).uniq.count
  end
end