class Review < ApplicationRecord
  belongs_to :user
  belongs_to :place

  has_one_attached :image

  with_options presence: true do
    validates :comment
    with_options numericality: true, inclusion: { in: 0.01..3_000 } do
      validates :download
      validates :upload
    end
  end

  validates :place_id, uniqueness: { scope: :user_id }
end
