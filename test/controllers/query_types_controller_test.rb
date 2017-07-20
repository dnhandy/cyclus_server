require 'test_helper'

class QueryTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @query_type = query_types(:one)
  end

  test "should get index" do
    get query_types_url, as: :json
    assert_response :success
  end

  test "should create query_type" do
    assert_difference('QueryType.count') do
      post query_types_url, params: { query_type: { name: @query_type.name } }, as: :json
    end

    assert_response 201
  end

  test "should show query_type" do
    get query_type_url(@query_type), as: :json
    assert_response :success
  end

  test "should update query_type" do
    patch query_type_url(@query_type), params: { query_type: { name: @query_type.name } }, as: :json
    assert_response 200
  end

  test "should destroy query_type" do
    assert_difference('QueryType.count', -1) do
      delete query_type_url(@query_type), as: :json
    end

    assert_response 204
  end
end
