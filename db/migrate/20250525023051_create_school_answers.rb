class CreateSchoolAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :school_answers do |t|
      t.references :question, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :answer

      t.timestamps
    end
  end
end
