class CreditsController < ApplicationController
  before_action :authenticate_requester!
  before_action :check_and_select_credit, only: %i[show edit update destroy]
  def new
    @credit = Credit.new
  end

  def create
    @credit = Credit.new(credit_params)
    @credit.parcel = @credit.send(:generate_pmt) if @credit.valid?

    return redirect_to @credit, notice: t(:credit_saved) if @credit.save

    flash.now[:alert] = t(:error)
    render :new
  end

  def show
  end

  def edit
  end

  def update
    if check_for_update

      @credit.parcel = @credit.send(:generate_pmt) if @credit.valid?

      message = t(:credit_saved).capitalize

      return redirect_to @credit, notice: message if @credit.save

    else
      flash.now[:alert] = t(:error).capitalize
    end
    render :edit
  end

  def destroy
    if can_modify? && @credit.destroy
      flash[:notice] = t(:credit_destroyed)
      redirect_to requester_dashboard_path
    else
      flash.now[:alert] = t(:error_on_delete)
      render :show
    end
  end

  private

  def credit_params
    params.require(:credit)
          .permit(:tax, :periods, :loan).merge(requester: current_requester)
  end

  def check_and_select_credit
    @credit = Credit.find(params[:id]) if exists_and_belongs
    redirect_to requester_dashboard_path unless exists_and_belongs
  end

  def check_for_update
    @credit.valid? && can_modify? && @credit.update(credit_params)
  end

  def exists_and_belongs
    exists = Credit.exists?(params[:id])
    owner = exists && Credit.find(params[:id]).requester == current_requester

    exists && owner ? true : false
  end

  def can_modify?
    !!(!@credit.already_accepted)
  end
end
