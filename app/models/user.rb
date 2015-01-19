class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook]
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :campaigns
  has_many :organizations, :through => :campaigns

  s3_credentials_hash = {
    :access_key_id => ENV['AWS_ACCESS_KEY'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
    :s3_permissions => :public_read
  }

  has_attached_file :avatar, 
                    :styles => { :small => "40x40#", :large => "200x200#" },
                    :s3_credentials => s3_credentials_hash,
                    :bucket => ENV['AWS_BUCKET'],
                    :default_url => "https://s3-us-west-2.amazonaws.com/raisechange/general/no-profile-image.png"

  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      # user.image = auth.info.image # assuming the user model has an image
      user.skip_confirmation!
    end
  end

  def to_param
    "#{id}-#{first_name.parameterize.downcase}-#{last_name.parameterize.downcase}"
  end
end
