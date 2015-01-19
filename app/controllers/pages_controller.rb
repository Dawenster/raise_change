class PagesController < ApplicationController
  def landing
    @campaigns = Campaign.all.sample(3)
  end
end