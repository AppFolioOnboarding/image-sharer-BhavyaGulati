require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
    get root_url
    assert_response :ok
    assert_select 'h1', 'Hello Bhavya'
  end

end
