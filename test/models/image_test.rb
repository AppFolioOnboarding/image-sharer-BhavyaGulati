require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'image is valid with a valid url' do
    image_valid = Image.new(url: 'https://www.appfolio.com/images/html/apm-fb-logo.png')
    assert_predicate image_valid, :valid?
  end
  test 'image is invalid with an invalid url' do
    image_invalid = Image.new(url: 'ww.appfolio.com/images/html/ap')
    assert_not_predicate image_invalid, :valid?
    assert_equal 'is not a valid HTTP URL', image_invalid.errors[:url].join('; ')
  end
end
