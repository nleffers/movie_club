# Controller for Reviews
class ReviewsController < ApplicationController
  before_action :get_review, only: %i[update destroy]

  def create
    review = Review.create(review_params.merge(user_id: User.current.id))

    render json: { id: review.id }, status: 200
  end

  def update
    @review.update(review_params)

    head :ok
  end

  def destroy
    @review.destroy

    head :ok
  end

  private

  def get_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:id,
                                   :movie_id,
                                   :title,
                                   :blog)
  end
end
