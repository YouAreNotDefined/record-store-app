require 'test_helper'

class RecordlibrariesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get recordlibraries_create_url
    assert_response :success
  end

  test "should get destroy" do
    get recordlibraries_destroy_url
    assert_response :success
  end

end
