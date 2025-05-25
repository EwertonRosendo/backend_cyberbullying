class SchoolAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :user_id, uniqueness: { scope: :question_id, message: "has already answered this question" }
end
