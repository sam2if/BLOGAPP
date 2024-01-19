class User < ApplicationRecord
  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
