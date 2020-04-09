class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: "User"
  belongs_to :state, optional: true

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  has_many :comments, dependent: :destroy
end
