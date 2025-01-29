class Prontuario < ApplicationRecord
  belongs_to :user
  validates :nome, presence: true
end
