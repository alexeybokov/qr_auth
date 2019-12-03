class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :show_qr, :qr_setup, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #@token = @user.qr_code
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.generate_token

    respond_to do |format|
      if @user.save
        format.html { redirect_to show_qr_path(id: @user.id) }
        #format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        flash[:alert] = "Something went wrong, try again"
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show_qr
    @qr_code = @user.qr_code
  end

  def qr_setup
    totp = ROTP::TOTP.new(@user.token)
    if totp.now.eql?(params[:authentication_code])
      redirect_to login_path
    else
      flash[:alert] = "Something went wrong"
      redirect_to root_path
    end
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
