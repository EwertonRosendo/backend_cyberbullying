require "test_helper"

class SchoolAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @school_answer = school_answers(:one)
  end

  test "should get index" do
    get school_answers_url
    assert_response :success
  end

  test "should get new" do
    get new_school_answer_url
    assert_response :success
  end

  test "should create school_answer" do
    assert_difference("SchoolAnswer.count") do
      post school_answers_url, params: { school_answer: { answer: @school_answer.answer, question_id: @school_answer.question_id, user_id: @school_answer.user_id } }
    end

    assert_redirected_to school_answer_url(SchoolAnswer.last)
  end

  test "should show school_answer" do
    get school_answer_url(@school_answer)
    assert_response :success
  end

  test "should get edit" do
    get edit_school_answer_url(@school_answer)
    assert_response :success
  end

  test "should update school_answer" do
    patch school_answer_url(@school_answer), params: { school_answer: { answer: @school_answer.answer, question_id: @school_answer.question_id, user_id: @school_answer.user_id } }
    assert_redirected_to school_answer_url(@school_answer)
  end

  test "should destroy school_answer" do
    assert_difference("SchoolAnswer.count", -1) do
      delete school_answer_url(@school_answer)
    end

    assert_redirected_to school_answers_url
  end
end
