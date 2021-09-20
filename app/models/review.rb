class Review < ApplicationRecord
  belongs_to :user
  belongs_to :place

  validates :download, presence: true
  validates :upload, presence: true
  validates :comment, presence: true
end
