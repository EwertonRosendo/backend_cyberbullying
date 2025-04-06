class Ticket < ApplicationRecord
    enum status: {
    created: 0,
    opened: 1,
    pending: 2,
    closed: 3,
  }
end
