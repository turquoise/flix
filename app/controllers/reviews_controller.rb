class ReviewsController < ApplicationController
  before_action :require_signin
	before_action :set_movie
	
	def index
  		#@movie = Movie.find(params[:movie_id])
  		@reviews = @movie.reviews
	end

  

	def new
  		#@movie = Movie.find(params[:movie_id])
  		@review = @movie.reviews.new
	end

	def create
  		#@movie = Movie.find(params[:movie_id])
  		@review = @movie.reviews.new(review_params)
      @review.user = current_user
  		if @review.save
    		redirect_to movie_reviews_path(@movie),
                  notice: "Thanks for your review!"
  		else
    		render :new
  		end
	end

	private

	def review_params
  		params.require(:review).permit(:comment, :stars)
	end

	def set_movie
  		@movie = Movie.find(params[:movie_id])
	end

end
