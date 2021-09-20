class LineKinds < ActiveHash::Base
  self.data= [
    { id: 1, name: '---'},
    { id: 2, name: "占有回線"},
    { id: 3, name: "共有回線"},
    { id: 4, name: "不明"},
  ]
  include ActiveHash::Associations
  has_many :places
end