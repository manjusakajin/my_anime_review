class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :find_anime

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new review_params
    @review.anime_id = @anime.id
    if @review.save
      flash[:success] = t "review.created"
      redirect_to current_user
    else
      render :new
    end
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
end
