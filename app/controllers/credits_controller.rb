class CreditsController < ApplicationController
  before_action :check_if_requester_or_admin
  before_action :check_and_select_credit, except: %i[new create]
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

  def update_parcels
    if pending_and_admin
      msg = 'Parcels generated successfully'
      redirect_to @credit, notice: msg if make_parcels
    else
      msg = 'Parcels generation error(probably already accepted)'
      flash.now[:alert] = msg
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
    admin = admin_signed_in?
    exists = Credit.exists?(params[:id])
    owner = exists && Credit.find(params[:id]).requester == current_requester

    exists && (owner || admin) ? true : false
  end

  def can_modify?
    !!(!@credit.already_accepted)
  end

  def check_if_requester_or_admin
    if admin_signed_in?
      authenticate_admin!
    else
      authenticate_requester!
    end
  end

  def make_parcels
    @credit.already_accepted = true
    @credit.save
    @credit.send(:generate_parcels)
  end

  def pending_and_admin
    admin = admin_signed_in?
    pending = !@credit.already_accepted
    admin && pending
  end
end
