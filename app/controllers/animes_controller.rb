class AnimesController < ApplicationController
  def index
    @animes = Anime.all
  end

  def show
    @anime = Anime.find_by id: params[:id]
    if @anime
      @reviews = @anime.reviews.order(created_at: :desc)
        .paginate page: params[:page], per_page: Settings.per_page
    else
      flash[:danger] = t "anime.not_found"
      redirect_to root_url
    end
  end
end
