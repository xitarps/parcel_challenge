class RequestersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @requesters = Requester.all
  end

  def show
    @requester = Requester.find(params[:id])
  end
end
