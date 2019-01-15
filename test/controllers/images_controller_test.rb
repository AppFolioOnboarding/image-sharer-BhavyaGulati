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
    assert_redirected_to root_path
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
end
