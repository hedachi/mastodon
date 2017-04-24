class AccountSiritoriDataController < ApplicationController
  before_action :set_account_siritori_datum, only: [:show, :edit, :update, :destroy]

  # GET /account_siritori_data
  def index
    @account_siritori_data = AccountSiritoriDatum.all
  end

  # GET /account_siritori_data/1
  def show
  end

  # GET /account_siritori_data/new
  def new
    @account_siritori_datum = AccountSiritoriDatum.new
  end

  # GET /account_siritori_data/1/edit
  def edit
  end

  # POST /account_siritori_data
  def create
    @account_siritori_datum = AccountSiritoriDatum.new(account_siritori_datum_params)

    if @account_siritori_datum.save
      redirect_to @account_siritori_datum, notice: 'Account siritori datum was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /account_siritori_data/1
  def update
    if @account_siritori_datum.update(account_siritori_datum_params)
      redirect_to @account_siritori_datum, notice: 'Account siritori datum was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /account_siritori_data/1
  def destroy
    @account_siritori_datum.destroy
    redirect_to account_siritori_data_url, notice: 'Account siritori datum was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_siritori_datum
      @account_siritori_datum = AccountSiritoriDatum.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def account_siritori_datum_params
      params.require(:account_siritori_datum).permit(:account_id, :level, :stamina)
    end
end
