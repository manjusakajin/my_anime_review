class Admin::AnimesController < ApplicationController
  before_action :check_login
  before_action :check_admin
  before_action :find_anime, only: [:edit, :update]

  def new
    @anime = Anime.new
    @genres = Genre.all
  end

  def edit
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

  def update
    if @anime.update_attributes anime_params
      flash[:success] = t "success.update"
      redirect_to @anime
    else
      render :edit
    end
  end

  private

  def anime_params
    params.require(:anime).permit :name, :introdution, :web_ratting, :image,
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

  def find_anime
    @anime = Anime.find_by id: params[:id]
    unless @anime
      flash[:danger] = t "danger.anime"
      redirect_to root_url
    end
  end
end
