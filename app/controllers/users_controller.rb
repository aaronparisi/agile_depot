require 'byebug'

class UsersController < ApplicationController
  include CurrentCart #paste the module code in this class
  before_action :set_cart
  before_action :set_user, only: [
    :show, 
    :edit, 
    :update, 
    :destroy, 
    :update_password, 
    :recover_password, 
    :password_confirmation,
    :confirm_password
  ]

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:name)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def password_confirmation
    
  end

  def confirm_password
    # if @user.password_digest == BCrypt::Password.create(params[:user][:password])
    if @user.try(:authenticate, params[:user][:password])
      redirect_to edit_user_path(@user)
    else
      redirect_to users_path, notice: "Looks like that's not the right password for #{@user.name}"
    end
  end
  
  
  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_url, notice: "User '#{@user.name}' was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: "User '#{@user.name}' was successfully updated." }
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

  def forgot_password
    @user = User.new
  end
  
  def send_password_reset_email
    @user = User.where(name: params[:user][:name], email: params[:user][:email]).first
    
    if @user
      UserMailer.reset(@user).deliver_later
      redirect_to check_email_users_path
    else
      redirect_to forgot_password_users_path, notice: "Invalid User/Email"
    end
  end
  
  def check_email
    
  end

  def recover_password
    
  end
  
  def update_password
    @user.password_digest = BCrypt::Password.create(params[:password])
    if @user.save
      redirect_to login_path, notice: "Password Successfully Updated"
    else
      redirect_to login_path, notice: "Password Did NOT reset, idk why"
    end
  end

rescue_from 'User::UserError' do |e|
  redirect_to users_url, notice: e.message
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
