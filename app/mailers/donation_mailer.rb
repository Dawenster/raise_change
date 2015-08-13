class DonationMailer < ActionMailer::Base
  helper :application # gives access to all helpers defined within `application_helper`.

  default from: '"Raise Change Team" <team@raisechange.org>'

  def successful_donation(donation_id, period)
    @donation = Donation.find(donation_id)
    @campaign = @donation.campaign
    @campaign_user = @campaign.user
    @user = @donation.user
    @name = @user.first_name
    @donation_period_name = period

    address = Mail::Address.new @user.email # ex: "john@example.com"
    address.display_name = @name if @name # ex: "John Doe"

    mail(from: '"Raise Change Team" <team@raisechange.com>', to: address.format, subject: "Thank you for supporting #{@campaign_user.full_name}")
  end

  def notify_creator_of_donation(donation_id, period)
    @donation = Donation.find(donation_id)
    @campaign = @donation.campaign
    @user = @campaign.user
    @name = @user.first_name
    @donor = @donation.user
    @donation_period_name = period

    address = Mail::Address.new @user.email # ex: "john@example.com"
    address.display_name = @name if @name # ex: "John Doe"

    mail(from: '"Raise Change Team" <team@raisechange.com>', to: address.format, subject: "#{@donor.full_name} supported your campaign")
  end
end