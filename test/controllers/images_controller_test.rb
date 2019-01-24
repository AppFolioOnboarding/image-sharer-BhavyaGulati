require 'test_helper'
class ImagesControllerTest < ActionDispatch::IntegrationTest # rubocop:disable Metrics/ClassLength
  def test_new
    get new_image_path
    assert_response :ok
    assert_select 'form', count: 1
  end

  def test_show__image_found
    image = Image.create!(url: 'https://www.xyz.com', tag_list: %w[Gmap earth])
    get image_path(image)
    assert_response :ok
    assert_select 'img', count: 1
    assert_select 'form[action= "/images"].button_to', value: 'See all images'
  end

  def test_show__image_not_found
    get image_path(-1)
    assert_redirected_to new_image_path
    assert_equal 'Id not found', flash[:danger]
  end

  def test_show__image_found__tag_found
    image = Image.create!(url: 'https://www.xyz.com', tag_list: %w[Gmap earth])
    get image_path(image)
    assert_response :ok
    assert_select 'li.js-tag_list_element', count: 2
  end

  def test_show__image_found__tag_not_found
    image = Image.create!(url: 'https://www.xyz.com', tag_list: [])
    get image_path(image)
    assert_response :ok
    assert_select 'li.js-tag_list_element', count: 0
  end

  def test_create__valid
    assert_difference 'Image.count' do
      post images_path, params: { image: {
        url: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png'
      } }
    end
    assert_redirected_to image_path(Image.last)
    follow_redirect!
    assert_select '.alert.alert-success', text: 'You have successfully added an image.'
  end

  def test_create__valid__with_tags
    assert_difference 'Image.count' do
      post images_path, params: { image: {
        url: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png', tag_list: %w[abc def]
      } }
    end
    assert_redirected_to image_path(Image.last)
    follow_redirect!
    assert_select '.alert.alert-success', text: 'You have successfully added an image.'
  end

  def test_create__valid__without_tags
    assert_difference 'Image.count' do
      post images_path, params: { image: {
        url: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png', tag_list: []
      } }
    end
    assert_redirected_to image_path(Image.last)
    follow_redirect!
    assert_select '.alert.alert-success', text: 'You have successfully added an image.'
  end

  def test_create__invalid
    assert_no_difference 'Image.count' do
      post images_path, params: { image: {
        url: 'htearn.appfolio.com/apm/www/images/apm-logo-v2.png'
      } }
      assert_response :unprocessable_entity
      assert_select '.alert.alert-danger', text: 'Could not save an image'
    end
  end

  def test_create__invalid__with_tags
    assert_no_difference 'Image.count' do
      post images_path, params: { image: {
        url: 'htearn.appfolio.com/apm/www/images/apm-logo-v2.png', tag_list: %w[abc def]
      } }
      assert_response :unprocessable_entity
      assert_select '.alert.alert-danger', text: 'Could not save an image'
    end
  end

  def test_create__invalid__without_tags
    assert_no_difference 'Image.count' do
      post images_path, params: { image: {
        url: 'htearn.appfolio.com/apm/www/images/apm-logo-v2.png', tag_list: []
      } }
      assert_response :unprocessable_entity
      assert_select '.alert.alert-danger', text: 'Could not save an image'
    end
  end

  def test_index
    get images_path
    assert_response :ok
    assert_select 'h3', 'All Images'
    assert_select '.button_to', count: 2
    assert_select 'form[action="/images"].button_to', value: 'Clear tag filter'
    assert_select 'form[action="/images/new"].button_to', value: 'Add new image'
  end

  def test_index__some_image_present
    Image.destroy_all
    Image.create!(url: 'https://www.xyz.com', tag_list: %w[Gmap earth])
    get images_path
    assert_response :ok
    assert_select 'img', count: 1
    assert_select '.btn.btn-success', text: 'Show'
  end

  def test_index__no_image
    Image.destroy_all
    get images_path
    assert_response :ok
    assert_select 'h3', 'All Images'
    assert_select 'img', count: 0
  end

  def test_index__tags
    Image.create!(url: 'https://www.xyz.com', tag_list: %w[Gmap earth])
    get images_path
    assert_response :ok
    assert_select 'h3', 'All Images'
    assert_select 'body > ul > li:nth-child(1) > ul > li', count: 2
    assert_select 'body > ul > li:nth-child(1) > ul > li:nth-child(1)', 'Gmap'
    assert_select 'body > ul > li:nth-child(1) > ul > li:nth-child(2)', 'earth'
  end

  def test_index__no_tags
    Image.create!(url: 'https://www.xyz.com', tag_list: [])
    get images_path
    assert_response :ok
    assert_select 'h3', 'All Images'
    assert_select 'body > ul > ul:nth-child(2) > li', count: 0
  end

  def test_index__correct_order
    image_old = Image.create!(url: 'https://www.gettyimages.com/gi-resources/images/Embed/new/embed2.jpg', created_at: Time.zone.now - 1.hour)
    image_new = Image.create!(url: 'https://festivalplacecdn.azureedge.net/media/1021/apple-logo-400x400.jpg?v=&quality=80', created_at: Time.zone.now)

    get images_path
    assert_response :ok

    assert_select "ul.js-image_list li.js-image_list_element:first-of-type img[src='#{image_new.url}']", count: 1
    assert_select "ul.js-image_list li.js-image_list_element:last-child img[src='#{image_old.url}']", count: 1
  end

  def test_index__image_by_tag__tag_found
    Image.destroy_all
    Image.create!(url: 'https://www.xyz.com', tag_list: %w[Gmap earth], created_at: Time.zone.now - 1.hour)
    Image.create!(url: 'https://www.abc.com', tag_list: %w[abc Gmap], created_at: Time.zone.now)
    get tag_path('Gmap')
    assert_response :ok
    assert_select 'ul.js-tag_list', count: 2
    assert_select 'body > ul > li:nth-child(1) > ul > li > a', count: 2
    assert_select 'body > ul > li:nth-child(1) > ul > li:nth-child(1) > a', 'abc'
    assert_select 'body > ul > li:nth-child(1) > ul > li:nth-child(2) > a', 'Gmap'
  end

  def test_index__image_by_tag__tag_not_found
    get tag_path(-1)
    assert_response :ok
    assert_select 'ul.js-tag_list', count: 0
    assert_equal 'Tags have no images associated', flash.now[:danger]
  end
end
