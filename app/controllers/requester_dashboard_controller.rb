class RequesterDashboardController < ApplicationController
  before_action :authenticate_requester!
  def index
  end
end
