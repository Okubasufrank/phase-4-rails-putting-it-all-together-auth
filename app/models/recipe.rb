class Recipe < ApplicationRecord

    validates :title , presence: true
    validates :instructions, length: { minimum: 50}, presence: true

    belongs_to :user
end