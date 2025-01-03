class PagesController < ApplicationController
  before_action :set_user, only: :home

  def home
    @user ? render_user_dashboard : render("home")
  end

  private

  def render_user_dashboard
    respond_to do |format|
      if turbo_frame_request? && turbo_frame_request_id == "content"
        format.html { render partial: "pages/partials/dash_#{params[:partial]}" }
      else
        format.html { render "user_home" }
      end
    end
  end

  def set_user
    @user = current_user if user_signed_in?
  end
end
