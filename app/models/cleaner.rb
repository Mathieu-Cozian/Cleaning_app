class Cleaner < ApplicationRecord
  belongs_to :user
  validates :address, presence: true
  accepts_nested_attributes_for :user

  enum status: {
    pending: 0,
    active: 1,
    inactive: 2,
    terminated: 3,
  }
end
