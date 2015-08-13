class ReachoutMailer < ActionMailer::Base
  helper :application # gives access to all helpers defined within `application_helper`.

  default from: '"Raise Change Team" <team@raisechange.org>'

  def nonprofit(nonprofit)
    @email = nonprofit[:email]
    @first_name = nonprofit[:first_name]
    @greeting = @first_name.blank? ? "Hello" : "Hi #{@first_name}"
    @nonprofit = nonprofit[:name]
    @nonprofit_short_name = nonprofit[:short_name]

    address = Mail::Address.new @email
    address.display_name = @first_name ? @first_name : @nonprofit

    mail(from: '"Ben Torn" <team@raisechange.com>', to: address.format, subject: "Raising funds for #{@nonprofit_short_name}")
  end
end