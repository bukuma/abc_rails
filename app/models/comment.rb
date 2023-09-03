class Comment < ApplicationRecord
  # Validation
  validates :content, presence: true, length: { maximum: 100 }
  
  belongs_to :post
end
