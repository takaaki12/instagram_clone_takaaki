class Comment < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :micropost
  validates :body , presence: true
  validates :user_id , presence: true
end
