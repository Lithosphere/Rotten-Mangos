class Admin::UsersController < ApplicationController

  before_filter :restrict_admin_access

  def index
    @users = User.order(:id).page(params[:page]).per(5)
    render :index
  end

  def new

    @user = User.new

  end

  def create

    @user = User.new(admin_params)
    if @user.save
      redirect_to admin_users_path, notice: "#{@user.full_name} was successfully created!"
    else
      render :new
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(admin_params)
      redirect_to admin_users_path, notice: "#{@user.firstname}'s info has been updated!"
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
      if @user.destroy
        # Tell the UserMailer to send a welcome email after save 
        UserMailer.delete_email(@user).deliver
        redirect_to admin_users_path, notice: "#{@user.full_name} has been deleted!"
      else
        render :show
      end
  end


  protected

  def restrict_admin_access

    if !current_user || (current_user.admin == nil || current_user.admin == false)
      flash[:alert] = "You must be an admin."
      redirect_to movies_path
    end

  end

  def admin_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
