require 'test_helper'

class InputFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @input_file = input_files(:one)
  end

  test "should get index" do
    get input_files_url, as: :json
    assert_response :success
  end

  test "should create input_file" do
    assert_difference('InputFile.count') do
      post input_files_url, params: { input_file: { name: @input_file.name, path: @input_file.path, sha1sum: @input_file.sha1sum } }, as: :json
    end

    assert_response 201
  end

  test "should show input_file" do
    get input_file_url(@input_file), as: :json
    assert_response :success
  end

  test "should update input_file" do
    patch input_file_url(@input_file), params: { input_file: { name: @input_file.name, path: @input_file.path, sha1sum: @input_file.sha1sum } }, as: :json
    assert_response 200
  end

  test "should destroy input_file" do
    assert_difference('InputFile.count', -1) do
      delete input_file_url(@input_file), as: :json
    end

    assert_response 204
  end
end
