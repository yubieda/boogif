require 'test_helper'

class ProfileControllerTest < ActionController::TestCase
  test "should get connections" do
    get :connections
    assert_response :success
  end

  test "should get reminders" do
    get :reminders
    assert_response :success
  end

end
