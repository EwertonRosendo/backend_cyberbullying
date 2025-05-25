require "application_system_test_case"

class SchoolAnswersTest < ApplicationSystemTestCase
  setup do
    @school_answer = school_answers(:one)
  end

  test "visiting the index" do
    visit school_answers_url
    assert_selector "h1", text: "School answers"
  end

  test "should create school answer" do
    visit school_answers_url
    click_on "New school answer"

    fill_in "Answer", with: @school_answer.answer
    fill_in "Question", with: @school_answer.question_id
    fill_in "User", with: @school_answer.user_id
    click_on "Create School answer"

    assert_text "School answer was successfully created"
    click_on "Back"
  end

  test "should update School answer" do
    visit school_answer_url(@school_answer)
    click_on "Edit this school answer", match: :first

    fill_in "Answer", with: @school_answer.answer
    fill_in "Question", with: @school_answer.question_id
    fill_in "User", with: @school_answer.user_id
    click_on "Update School answer"

    assert_text "School answer was successfully updated"
    click_on "Back"
  end

  test "should destroy School answer" do
    visit school_answer_url(@school_answer)
    click_on "Destroy this school answer", match: :first

    assert_text "School answer was successfully destroyed"
  end
end
