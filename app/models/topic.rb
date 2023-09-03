class Topic < ApplicationRecord
  # Validation
  validates :title, presence: true

  validates :body, length: { maximum: 100 }

  # ActiveStorage
  has_one_attached :image
end
