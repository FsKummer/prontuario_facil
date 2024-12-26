class PagesController < ApplicationController
  def home
    if user_signed_in?
      render "user_home"
    else
      render "home"
    end
  end
end
