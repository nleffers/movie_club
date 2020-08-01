# Controller for Reviews
class ReviewsController < ApplicationController
  before_action :get_review, only: %i[update]

  def create
    review = Review.create(create_params.merge(user_id: User.current.id))

    render json: { id: review.id }, status: 200
  end

  def update
    Review.find(params[:id]).update(edit_params)

    head :ok
  end

  private

  def create_params
    params.require(:review).permit(:imdb_id,
                                   :title,
                                   :blog)
  end

  def edit_params
    params.require(:review).permit(:id,
                                   :imdb_id,
                                   :title,
                                   :blog)
  end
end
