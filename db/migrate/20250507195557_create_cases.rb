class CreateCases < ActiveRecord::Migration[7.2]
  def change
    create_table :cases do |t|
      t.references :user, null: false, foreign_key: true
      t.text :description
      t.text :institution_answer

      t.timestamps
    end
  end
end
