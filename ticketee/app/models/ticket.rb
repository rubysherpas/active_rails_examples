class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: "User"
  belongs_to :state, optional: true

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  has_many_attached :attachments

  has_many :comments, dependent: :destroy

  before_create :assign_default_state

  private

  def assign_default_state
    self.state ||= State.default
  end
end
