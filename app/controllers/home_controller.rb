class HomeController < ApplicationController
  before_action :redirect_logged_to_dashboard
  def index
  end

  private

  def logged_in?
    !!(admin_signed_in? || requester_signed_in?)
  end

  def redirect_logged_to_dashboard
    redirect_to admin_dashboard_path if logged_in? && admin_signed_in?
    redirect_to requester_dashboard_path if logged_in? && requester_signed_in?
  end
end
