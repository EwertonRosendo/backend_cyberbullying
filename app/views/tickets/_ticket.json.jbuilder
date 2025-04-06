json.extract! ticket, :id, :email, :ticket_description, :status, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
