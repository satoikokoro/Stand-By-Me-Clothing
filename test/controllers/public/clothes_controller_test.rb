require "test_helper"

class Public::ClothesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_clothes_index_url
    assert_response :success
  end

  test "should get show" do
    get public_clothes_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_clothes_edit_url
    assert_response :success
  end
end
