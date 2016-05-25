class User < ActiveRecord::Base
  has_many :reviews
  has_secure_password

  validates :user, presence: true
  validates :movie, presence: true
  validates :text, presence: true
  validates :rating_out_of_ten, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
end
