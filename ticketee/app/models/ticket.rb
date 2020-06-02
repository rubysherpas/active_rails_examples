class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: "User"
  has_many_attached :attachments

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }
end
