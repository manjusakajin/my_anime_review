class UsersController < ApplicationController
  before_action :logged_in_user, only: :show
  before_action :find_user, only: :show

  def index
    @users = User.all.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    if @user
      @reviews = @user.reviews.order(created_at: :desc)
        .paginate page: params[:page], per_page: Settings.per_page
      @relationship =
        if current_user.active_relationships.find_by followed_id: @user.id
          current_user.active_relationships.find_by followed_id: @user.id
        else
          current_user.active_relationships.build
        end
    else
      flash[:danger] = t "danger.not_found"
      redirect_to root_url
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "info.activation"
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "danger.not_found"
      redirect_to root_url
    end
  end
end
