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

  test 'image is invalid with a blank url' do
    image_invalid = Image.new(url: '')
    assert_not_predicate image_invalid, :valid?
    assert_equal "can't be blank", image_invalid.errors[:url].join('; ')
  end
  test 'image creation with no tags' do
    image_valid = Image.new(url: 'https://www.appfolio.com/images/html/apm-fb-logo.png', tag_list: %w[])
    assert_predicate image_valid, :valid?
  end

  test 'image creation with tags' do
    image_valid = Image.new(url: 'https://www.appfolio.com/images/html/apm-fb-logo.png', tag_list: %w[abc xyz])
    assert_predicate image_valid, :valid?
    assert_equal image_valid.tag_list.count, 2
    assert_equal %w[abc xyz], image_valid.tag_list
  end
end
