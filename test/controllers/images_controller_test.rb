require 'test_helper'
class ImagesControllerTest < ActionDispatch::IntegrationTest # rubocop:disable Metrics/ClassLength
  def test_new
    get new_image_path
    assert_response :ok
    assert_select 'form', count: 1
  end

  def test_show__image_found
    image = Image.first
    get image_path(image)
    assert_response :ok
    assert_select 'img', count: 1
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
    assert_select 'li.tag_list_class', count: 2
  end

  def test_show__image_found__tag_not_found
    image = Image.create!(url: 'https://www.xyz.com', tag_list: [])
    get image_path(image)
    assert_response :ok
    assert_select 'li.tag_list_class', count: 0
  end

  def test_create__valid
    assert_difference 'Image.count' do
      post images_path, params: { image: {
        url: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png'
      } }
    end
  end

  def test_create__valid__with_tags
    assert_difference 'Image.count' do
      post images_path, params: { image: {
        url: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png', tag_list: %w[abc def]
      } }
    end
  end

  def test_create__valid__without_tags
    assert_difference 'Image.count' do
      post images_path, params: { image: {
        url: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png', tag_list: []
      } }
    end
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
    assert_select 'h1', 'All Images'
  end

  def test_index__no_image
    Image.destroy_all
    get images_path
    assert_response :ok
    assert_select 'h1', 'All Images'
    assert_select 'img', count: 0
  end

  def test_index__tags
    Image.create!(url: 'https://www.xyz.com', tag_list: %w[Gmap earth])
    get images_path
    assert_response :ok
    assert_select 'h1', 'All Images'
    assert_select 'body > ul > ul:nth-child(2) > li', count: 2
    assert_select 'body > ul > ul:nth-child(2) > li:nth-child(1)', 'Gmap'
    assert_select 'body > ul > ul:nth-child(2) > li:nth-child(2)', 'earth'
  end

  def test_index__no_tags
    Image.create!(url: 'https://www.xyz.com', tag_list: [])
    get images_path
    assert_response :ok
    assert_select 'h1', 'All Images'
    assert_select 'body > ul > ul:nth-child(2) > li', count: 0
  end

  def test_index__correct_order
    image_old = Image.create!(url: 'https://www.gettyimages.com/gi-resources/images/Embed/new/embed2.jpg', created_at: Time.zone.now - 1.hour)
    image_new = Image.create!(url: 'https://festivalplacecdn.azureedge.net/media/1021/apple-logo-400x400.jpg?v=&quality=80', created_at: Time.zone.now)

    get images_path
    assert_response :ok

    assert_select "ul.image_list li.image_list_element:first-of-type img[src='#{image_new.url}']", count: 1
    assert_select "ul.image_list li.image_list_element:last-child img[src='#{image_old.url}']", count: 1
  end
end
