class ReviewsController < ApplicationController
  before_action :logged_in_user, except: [:show, :index]
  before_action :find_anime, except: [:index]
  before_action :find_review, only: [:edit, :update, :destroy]

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find_by id: params[:id]
    unless @review
      flash[:danger] = t "review.not_found"
      redirect_to root_url
    end
  end

  def new
    if current_user.reviewed? @anime
      flash[:danger] = t "review.fobid"
      redirect_to root_url
    else
      @review = Review.new
    end
  end

  def create
    @review = current_user.reviews.new review_params
    @review.anime_id = @anime.id
    if @review.save
      flash[:success] = t "review.created"
      redirect_to anime_review_path @anime, @review
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "review.updated"
      redirect_to anime_review_path @anime, @review
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    flash[:success] = t "review.deleted"
    redirect_to root_url
  end

  private

  def review_params
    params.require(:review).permit :title, :content
  end

  def find_anime
    @anime = Anime.find params[:anime_id]
    unless @anime
      flash[:danger] = t "danger.find_anime", param: params[:anime_id]
      redirect_to root_path
    end
  end

  def find_review
    @review = current_user.reviews.find_by id: params[:id]
    unless @review
      flash[:danger] = t "danger.access"
      redirect_to root_path
    end
  end
end
