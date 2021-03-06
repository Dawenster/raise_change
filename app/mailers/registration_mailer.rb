class RegistrationMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

  default from: '"Raise Change Team" <team@raisechange.org>'

  def confirmation_instructions(resource, token, opts={})
    opts[:subject] = "Confirm your Raise Change account"
    @name = resource.first_name
    @name ||= resource.email
    super
  end

  def reset_password_instructions(resource, token, opts={})
    opts[:subject] = "Confirm your Raise Change account"
    @name = resource.first_name
    @name ||= resource.email
    super
  end

  def unlock_instructions(resource, token, opts={})
    opts[:subject] = "Confirm your Raise Change account"
    @name = resource.first_name
    @name ||= resource.email
    super
  end
end