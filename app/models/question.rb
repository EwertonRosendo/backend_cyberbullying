class Question < ApplicationRecord
    validates :school, presence: true
    has_many :school_answers, dependent: :destroy

end
