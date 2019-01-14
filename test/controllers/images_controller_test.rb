require 'test_helper'
class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_path
    assert_response :ok
    assert_select 'form', count: 1
  end

  def test_show
    image = Image.first
    get image_path(image)
    assert_response :ok
    assert_select 'img', count: 1
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
    end
  end
end
