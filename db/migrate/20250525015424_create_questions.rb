class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.string :school
      t.text :question
      t.text :answer

      t.timestamps
    end
  end
end
