class PagesController < ApplicationController
  before_action :ensure_user_logged_in
  include Constants::PagesControllerConstants

  def home
    @user ? render_user_dashboard : render("home")
  end

  private

  def render_user_dashboard
    set_user_prontuaries
    respond_to do |format|
      if turbo_content_request?
        begin
          partial = define_partial(params[:partial])
          format.html { render partial: "#{DASHBOARD_BASE_PATH}#{partial}" }
        rescue ActionView::MissingTemplate
          flash[:alert] = NOT_IMPLEMENTED_MESSAGE
          format.html { render USER_HOME_PARTIAL }
        end
      else
        format.html { render USER_HOME_PARTIAL }
      end
    end
  end

  def define_partial(partial_param)
    ALLOWED_PARTIALS.include?(partial_param) ? partial_param : "not_implemented"
  end

  def set_user
    @user = current_user if user_signed_in?
  end

  def turbo_content_request?
    turbo_frame_request? && turbo_frame_request_id == USER_DASHBOARD_TURBO_FRAME
  end

  def set_user_prontuaries
    @prontuarios ||= @user.prontuarios
  end

  def ensure_user_logged_in
    set_user
    render("home") unless @user
  end
end
