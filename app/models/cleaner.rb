class Cleaner < ApplicationRecord
  belongs_to :user
  validates :address, presence: true
  accepts_nested_attributes_for :user
end
