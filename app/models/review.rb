class Review < ApplicationRecord
  belongs_to :user
  belongs_to :place

  has_one_attached :image

  validates :download, presence: true
  validates :upload,   presence: true
  validates :comment,  presence: true
end
