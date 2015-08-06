class PagesController < ApplicationController
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
    @title = "Raise Change <span class='highlight'>records</span> your story as you help <span class='highlight'>influence</span> and <span class='highlight'>communicate</span> change."
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/generic_shovel.jpg"
  end
end