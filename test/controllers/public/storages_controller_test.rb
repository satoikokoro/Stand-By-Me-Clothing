require "test_helper"

class Public::StoragesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_storages_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_storages_edit_url
    assert_response :success
  end
end
