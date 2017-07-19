class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog
  validates :content, presence: true
  has_many :notifications, dependent: :destroy
end
