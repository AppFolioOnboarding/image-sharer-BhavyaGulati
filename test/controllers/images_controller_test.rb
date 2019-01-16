require 'test_helper'
class ImagesControllerTest < ActionDispatch::IntegrationTest
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

  def test_create__valid
    assert_difference 'Image.count' do
      post images_path, params: { image: {
        url: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png'
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

  def test_index__correct_order
    image_old = Image.create!(url: 'https://www.gettyimages.com/gi-resources/images/Embed/new/embed2.jpg')
    image_new = Image.create!(url: 'https://www.xyz.com')

    get images_path
    assert_response :ok

    assert_select "li:last-child img[src='#{image_old.url}']", count: 1
    assert_select "li:first-child img[src='#{image_new.url}']", count: 1
  end
end
