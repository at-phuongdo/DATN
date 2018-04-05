require 'test_helper'

class Api::V1::ConvenientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_convenients_index_url
    assert_response :success
  end

end
