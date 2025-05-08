class AddKindToUsers < ActiveRecord::Migration[6.0] # or your version
  def change
    add_column :users, :kind, :integer, default: 0, null: false
  end
end
