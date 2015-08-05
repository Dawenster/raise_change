class Campaign < ActiveRecord::Base
  validates :title, :organization_name, :description, presence: true

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

  # def to_param
  #   "#{id}-#{title.parameterize}"
  # end

  def donations_per_hour_in_cents
    self.donations.sum(:amount)
  end

  def donations_per_hour
    donations_per_hour_in_cents.to_f / 100
  end

  def num_sponsors
    self.donations.select(:user_id).uniq.count
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
    facebook_app_id = Rails.env.development? ? 952931041384040 : 952917808052030
    facebook_link = "https://www.facebook.com/dialog/feed"
    facebook_link += "?app_id=#{facebook_app_id}"
    facebook_link += "&display=popup"
    facebook_link += "&caption=Raise%20Change"
    facebook_link += "&link=#{url}"
    facebook_link += "&redirect_uri=#{url}"
    facebook_link += "&picture=#{self.image.url(:display)}"

    twitter_link = "https://twitter.com/intent/tweet"
    twitter_link += "?text=#{self.title}"
    twitter_link += "&url=#{url}"
    twitter_link += "&hashtags=raisechange"

    linkedin_link = "https://www.linkedin.com/shareArticle"
    linkedin_link += "?mini=true"
    linkedin_link += "&url=#{url}"
    linkedin_link += "&title=#{self.title}"

    email_link ="mailto:?subject=#{self.title}&body=#{url}"

    str = "<a href='" + facebook_link + "' target='_blank'><i class='fa fa-facebook-square'></i></a>"
    str += "<a href='" + twitter_link + "' target='_blank'><i class='fa fa-twitter-square'></i></a>"
    str += "<a href='" + linkedin_link + "' target='_blank'><i class='fa fa-linkedin-square'></i></a>"
    str += "<a href='" + email_link + "' target='_blank'><i class='fa fa-envelope-square'></i></a>"

    return str
  end

  def estimated_hours_per_quarter
    if self.frequency == "monthly"
      multiple = 3
    elsif self.frequency == "weekly"
      multiple = 13
    end

    if self.estimated_hours.nil? || multiple.nil?
      return 15
    else
      return self.estimated_hours * multiple
    end
  end
end