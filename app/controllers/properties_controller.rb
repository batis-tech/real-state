class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!, only: [:new,:create,:destroy]
  before_action :set_sidebar, except: [:show]
  # GET /properties or /properties.json
  def index
    @properties = Property.all
  end

  # GET /properties/1 or /properties/1.json
  def show
    @agent = @property.account
    @properties_agent = Property.latest.where('id != ?',params[:id])

  end
  def contact
    @agents = Account.find(params[:id])
  end

  def email_agent
    #trigger an email secondary

    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    message = params[:message]
    agent_id = params[:agent_id]
    # response to script
    logger.debug "agent_id : #{agent_id}"
    logger.debug "First name: #{first_name}"
    logger.debug "Last name: #{last_name}"
    logger.debug "Email: #{email}"
    logger.debug "message: #{message}"

      respond_to do |format|
    format.json { head :no_content}
    end
  end
  # GET /properties/new
  def new
    @property = Property.new

  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties or /properties.json
  def create
    @property = Property.new(property_params)
    @property.account_id = current_account.id

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: "Property was successfully created." }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1 or /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: "Property was successfully updated." }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1 or /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: "Property was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_sidebar
    @set_sidebar = true
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(:name, :address, :price, :room, :bathrooms, :photo, :photo_cache, :parking_spaces, :details, :for_sale, :available_date)
    end
end
