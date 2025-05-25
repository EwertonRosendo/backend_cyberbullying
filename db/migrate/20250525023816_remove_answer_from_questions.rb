class RemoveAnswerFromQuestions < ActiveRecord::Migration[7.2]
  def change
    remove_column :questions, :answer, :string
  end
end
