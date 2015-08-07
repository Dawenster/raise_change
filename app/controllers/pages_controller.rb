class PagesController < ApplicationController
  include FaqHelper

  def landing
    if current_user
      @activities = current_user.newsfeed
      @title = "News <span class='highlight'>feed</span>"
      @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
    end
  end

  def how_it_works
    @title = "How it <span class='highlight'>works</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
  end

  def about
    @title = "About <span class='highlight'>Raise Change</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
  end

  def faq
    @title = "Frequently Asked <span class='highlight'>Questions</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
    @sections = sections
  end

  def terms
    @title = "Terms and <span class='highlight'>Conditions</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
  end

  def privacy
    @title = "Privacy <span class='highlight'>policy</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
  end
end