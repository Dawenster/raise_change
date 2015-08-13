class Campaign < ActiveRecord::Base
  validates :title, :organization_name, :description, presence: true

  belongs_to :user
  belongs_to :organization
  has_many :donations, :dependent => :destroy
  has_many :journal_entries, :dependent => :destroy

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

  # def to_param
  #   "#{id}-#{title.parameterize}"
  # end

  def donations_per_hour_in_cents
    self.donations.sum(:amount)
  end

  def donations_per_hour
    donations_per_hour_in_cents.to_f / 100
  end

  def num_supporters
    self.donations.select(:user_id).uniq.count
  end

  def unique_supporters
    self.donations.map{|donation| donation.user}.uniq
  end

  def num_hours
    self.journal_entries.sum(:hours)
  end

  def total_donations_raised_in_cents
    donations_per_hour_in_cents * num_hours
  end

  def total_donations_raised_in_dollars
    total_donations_raised_in_cents.to_f / 100
  end

  def social_links_as_string(url)
    str = "<a href='" + ApplicationController.helpers.facebook_link(url, self) + "' target='_blank'><i class='fa fa-facebook-square'></i></a>"
    str += "<a href='" + ApplicationController.helpers.twitter_link(url, self) + "' target='_blank'><i class='fa fa-twitter-square'></i></a>"
    str += "<a href='" + ApplicationController.helpers.linkedin_link(url, self) + "' target='_blank'><i class='fa fa-linkedin-square'></i></a>"
    str += "<a href='" + ApplicationController.helpers.email_link(url, self) + "' target='_blank'><i class='fa fa-envelope-square'></i></a>"
    return str
  end

  def estimated_hours_per_period
    if self.frequency == "monthly"
      multiple = 12 / ApplicationController.helpers.donation_periods_per_year
    elsif self.frequency == "weekly"
      multiple = 52.0 / ApplicationController.helpers.donation_periods_per_year
    end

    if self.estimated_hours.nil? || multiple.nil?
      return 4
    else
      return self.estimated_hours * multiple
    end
  end
end