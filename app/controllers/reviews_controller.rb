# Controller for Reviews
class ReviewsController < ApplicationController
  before_action :get_review, only: %i[update destroy]

  def create
    Review.create(review_params)
  end

  def update
    @review.update(review_params)

    @review
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
    params.require(:id,
                   :movie_id,
                   :user_id,
                   :rating,
                   :title,
                   :blog)
  end
end
