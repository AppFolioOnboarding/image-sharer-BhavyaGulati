require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  test 'should create an feedback' do
    assert_difference 'Feedback.count' do
      post api_feedbacks_path, params: { feedback: {
        name: 'Selenium Gomez',
        feedback: 'Go team!'
      } }
    end
  end
end
