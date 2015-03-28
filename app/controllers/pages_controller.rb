class PagesController < ApplicationController
  def how_it_works
    @title = "How it <span class='highlight'>works</span>"
    @image = "https://s3-us-west-2.amazonaws.com/raisechange/general/volunteer.jpg"
  end
end