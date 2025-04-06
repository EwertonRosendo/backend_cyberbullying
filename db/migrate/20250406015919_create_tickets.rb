class CreateTickets < ActiveRecord::Migration[7.2]
  def change
    create_table :tickets do |t|
      t.string :email
      t.text :ticket_description
      t.integer :status

      t.timestamps
    end
  end
end
