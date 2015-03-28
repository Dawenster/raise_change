class PagesController < ApplicationController
  def how_it_works
    @title = "How it <span class='highlight'>works</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/volunteer.jpg"
  end

  def about
    @title = "￼Raise Change is a tool to <span class='highlight'>record</span> your story as you help <span class='highlight'>influence</span> and <span class='highlight'>communicate</span> change."
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/volunteer2.jpg"
  end
end