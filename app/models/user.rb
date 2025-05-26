class User < ApplicationRecord
    has_secure_password
    has_many :school_answers
    has_many :cases

    has_one_attached :photo
    enum kind: { regular: 0, admin: 1 }
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }, on: :create
    validates :school, presence: true
end
