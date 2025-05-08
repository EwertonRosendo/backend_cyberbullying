class User < ApplicationRecord
    has_secure_password
    has_one_attached :photo
    enum kind: { regular: 0, admin: 1 }
end
