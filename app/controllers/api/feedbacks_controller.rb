module Api
  class FeedbacksController < ApplicationController
    def create
      Feedback.create!(params.require(:feedback).permit(:name, :feedback))
    end
  end
end
