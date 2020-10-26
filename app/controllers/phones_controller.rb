class PhonesController < ApplicationController
  before_action :authenticate_requester!
  def index
    @phones = current_requester.phones
  end

  def new
    @phone = Phone.new
  end

  def create
    @phone = current_requester.phones.new(phone_params)
    msg = 'Phone added'

    return redirect_to @phone, notice: msg if @phone.save

    flash.now[:alert] = 'Error on Phone save'
    render :new
  end

  def show
    @phone = current_requester.phones.find(params[:id])
  end

  def edit
    @phone = current_requester.phones.find(params[:id])
  end

  def update
    @phone = current_requester.phones.find(params[:id])
    msg = 'Phone updated'

    return redirect_to @phone, notice: msg if @phone.update(phone_params)

    flash.now[:alert] = 'Error on Phone save'
    render :show
  end

  def destroy
    set_addresses_if_exists

    return redirect_to phones_path, notice: @ms if @exists && @phone.destroy

    flash.now[:alert] = 'Error on Phone remove'
    render :index
  end

  private

  def phone_params
    params.require(:phone).permit(:number)
  end

  def set_addresses_if_exists
    @exists = Phone.exists?(params[:id])
    @phone = current_requester.phones.find(params[:id]) if @exists
    @ms = 'Phone number removed'
    @phones = current_requester.phones
  end
end
