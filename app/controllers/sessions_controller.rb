class SessionsController < Devise::SessionsController
  def new
    @title = "<span class='highlight'>Login</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
    @center = true

    super
  end
end