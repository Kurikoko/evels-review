class Place < ApplicationRecord
  
  has_many :reviews
  has_many :place_users
  has_many :users, through: :place_users
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area
  belongs_to :line_kinds
  belongs_to :fee
  belongs_to :backup_line
  belongs_to :wifi

  with_options presence: true do
    validates :place_name, uniqueness: true
    validates :image
    validates :carrier
  end

  with_options numericality: {other_than: 1, message: "が選択されていません"} do
    validates :area_id
    validates :line_kinds_id
    validates :fee_id
    validates :backup_line_id
    validates :wifi_id
  end

end
