class Post < ApplicationRecord
  # Validation
  validates :title, presence: true
  validates :body, presence: true

  # ActiveStorage
  has_one_attached :image
  # 2-13 追加
  has_many :comments, dependent: :destroy
end
