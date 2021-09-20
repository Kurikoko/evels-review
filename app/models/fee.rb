class Fee < ActiveHash::Base
  self.data= [
    { id: 1, name: '---'},
    { id: 2, name: "会場使用量に含む"},
    { id: 3, name: "別途発生"},
  ]
  include ActiveHash::Associations
  has_many :places
end