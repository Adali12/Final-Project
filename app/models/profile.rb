class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :pic
  has_one_attached :cv
  has_many :comments, dependent: :destroy
end
