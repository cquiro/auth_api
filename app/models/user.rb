class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :image, presence: true
end
