class Place < ApplicationRecord
  
  has_many :place_users
  has_many :users, through: :place_users
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area
  belongs_to :line_kinds
  belongs_to :fee
  belongs_to :backup_line
  belongs_to :wifi

  validates :place_name,     presence: true
  validates :area_id,        presence: true
  validates :carrier,        presence: true
  validates :line_kinds_id,  presence: true
  validates :fee_id,         presence: true
  validates :backup_line_id, presence: true
  validates :wifi_id,        presence: true
  validates :image,          presence: true
end
