class SetDefauldValueOnStatusToTickets < ActiveRecord::Migration[7.2]
  def change
    change_column_default :tickets, :status, 0
  end
end
