class AnimesController < ApplicationController
  def index
    @animes = Anime.all
  end

  def show
    @anime = Anime.find_by id: params[:id]
    if @anime
      @reviews = @anime.reviews
    else
      flash[:danger] = t "anime.notfound"
      redirect_to root_url
    end
  end
end
