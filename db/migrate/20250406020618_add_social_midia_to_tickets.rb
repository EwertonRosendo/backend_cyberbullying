class AddSocialMidiaToTickets < ActiveRecord::Migration[7.2]
  def change
    add_column :tickets, :social_midia, :string
  end
end
