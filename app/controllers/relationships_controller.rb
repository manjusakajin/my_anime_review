class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user, only: [:index, :create, :destroy]

  def index
    @title = t "follow.#{params[:page]}"
    @users = @user.send params[:page]
  end

  def create
    current_user.follow @user
    @relationship =
      current_user.active_relationships.find_by(followed_id: @user.id)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    current_user.unfollow @user
    @relationship = current_user.active_relationships.build
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  def find_user
    @user = User.find_by id: params[:user_id]
    unless @user
      flash[:danger] = t "danger.not_found"
    end
  end
end
