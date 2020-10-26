class AddressesController < ApplicationController
  before_action :authenticate_requester!
  def index
    @addresses = current_requester.addresses
  end

  def new
    @address = Address.new
  end

  def create
    @address = current_requester.addresses.new(fetched_params)
    msg = 'Address added'

    return redirect_to @address, notice: msg if @address.save

    flash.now[:alert] = 'Error on Address save'
    render :new
  end

  def show
    @address = current_requester.addresses.find(params[:id])
  end

  def edit
    @address = current_requester.addresses.find(params[:id])
  end

  def update
    @address = current_requester.addresses.find(params[:id])
    msg = 'Address updated'

    return redirect_to @address, notice: msg if @address.update(fetched_params)

    flash.now[:alert] = 'Error on Address save'
    render :show
  end

  def destroy
    set_addresses_if_exists

    return redirect_to addresses_path, notice: @ms if @exist && @address.destroy

    flash.now[:alert] = 'Error on Address remove'
    render :index
  end

  private

  def address_params
    params.require(:address).permit(:requester_zip_code, :number)
  end

  def fetch_address_data
    code = address_params[:requester_zip_code]
    api_http = "http://viacep.com.br/ws/#{code}/json/"
    response = Faraday.get api_http
    @json = if response.success?
              JSON.parse(response.body, symbolize_names: true)
            else
              JSON.parse(JSON[{}])
            end
  end

  def fetched_params
    fetch_address_data
    address_params.merge(state: @json[:uf],
                         city: @json[:localidade],
                         street: @json[:logradouro])
  end

  def set_addresses_if_exists
    @exist = Address.exists?(params[:id])
    @address = current_requester.addresses.find(params[:id]) if @exist
    @ms = 'Address number removed'
    @addresses = current_requester.addresses
  end
end
