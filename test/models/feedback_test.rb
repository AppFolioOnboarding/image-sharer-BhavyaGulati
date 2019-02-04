require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  test 'feedback invalid on name blank' do
    feedback_invalid = Feedback.new(name: '', feedback: 'Good')
    assert_not_predicate feedback_invalid, :valid?
  end

  test 'feedback invalid on feedback blank' do
    feedback_invalid = Feedback.new(name: 'bhavya', feedback: '')
    assert_not_predicate feedback_invalid, :valid?
  end

  test 'feedback valid' do
    feedback_valid = Feedback.new(name: 'bhavya', feedback: 'Gulati')
    assert_predicate feedback_valid, :valid?
  end
end
