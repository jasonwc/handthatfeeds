require 'test_helper'

class LegislatorsControllerTest < ActionController::TestCase
  test "should get your_legislators" do
    get :your_legislators
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
