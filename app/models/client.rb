class Client < ApplicationRecord
  belongs_to :user
  has_many :apartments
  accepts_nested_attributes_for :user
end
