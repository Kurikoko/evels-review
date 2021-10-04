class Wifi < ActiveHash::Base
  self.data= [
    { id: 1, name: '---'},
    { id: 2, name: "有り"},
    { id: 3, name: "無し"},
    { id: 4, name: "不明"}
  ]
  include ActiveHash::Associations
  has_many :places
end