class Place < ApplicationRecord
  
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area

 

  validates :place_name, presence: true
  validates :area_id, presence: true
  validates :image, presence: true
end
