class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook]
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :campaigns
  has_many :donations
  has_many :journal_entries
  has_many :organizations, :through => :campaigns
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  s3_credentials_hash = {
    :access_key_id => ENV['AWS_ACCESS_KEY'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }

  has_attached_file :avatar, 
                    :styles => { :small => "40x40#", :large => "200x200#" },
                    :s3_credentials => s3_credentials_hash,
                    :bucket => ENV['AWS_BUCKET'],
                    :default_url => "https://s3-us-west-2.amazonaws.com/raisechange/general/no_profile.png",
                    :s3_protocol => :https

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

  def full_name
    "#{first_name} #{last_name}"
  end

  def create_or_update_stripe_customer(token)
    stripe_setup

    begin
      if self.stripe_id
        customer = retrieve_customer
        customer.card = token
        customer.save
      else
        response = Stripe::Customer.create(
          :description => self.email,
          :card => token
        )
        self.update_attributes(:stripe_id => response.id)
      end
      return {:success => true}
    rescue => e
      handle_stripe_error(e)
    end
  end

  def has_credit_cards?
    return false unless self.stripe_id
    self.credit_cards.any?
  end

  def credit_cards
    stripe_setup
    return retrieve_customer.cards.all()
  end

  def delete_credit_card
    stripe_setup
    customer = retrieve_customer
    card_id = customer.cards.data[0].id
    last4 = customer.cards.data[0].last4
    customer.cards.retrieve(card_id).delete
    return last4
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

  def stripe_setup
    Stripe.api_key = Rails.env.production? ? ENV["STRIPE_LIVE_SECRET_KEY"] : ENV["STRIPE_TEST_SECRET_KEY"]
  end

  def retrieve_customer
    Stripe::Customer.retrieve(self.stripe_id)
  end

  def handle_stripe_error(e)
    body = e.json_body
    err  = body[:error]
    return {:success => false, :message => err[:message]}
  end
end
