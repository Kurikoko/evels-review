class BackupLine < ActiveHash::Base
  self.data= [
    { id: 1, name: '---'},
    { id: 2, name: "あり"},
    { id: 3, name: "なし"},
    { id: 4, name: "不明"}
  ]
  include ActiveHash::Associations
  has_many :places
end