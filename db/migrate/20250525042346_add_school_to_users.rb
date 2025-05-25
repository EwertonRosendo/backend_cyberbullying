class AddSchoolToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :school, :string
  end
end
