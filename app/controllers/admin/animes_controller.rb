class Admin::AnimesController < ApplicationController
  before_action :check_login
  before_action :check_admin

  def new
    @anime = Anime.new
    @genres = Genre.all
  end

  def create
    @anime = Anime.new anime_params
    if @anime.save
      flash[:success] = t "success.anime"
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def anime_params
    params.require(:anime).permit :name, :introdution, :web_ratting,
      genre_ids: []
  end

  def check_admin
    unless current_user.is_admin?
      flash[:danger] = t "danger.create_anime"
      redirect_to root_url
    end
  end

  def check_login
    unless logged_in?
      flash[:danger] = t "danger.login"
      redirect_to login_path
    end
  end
end
