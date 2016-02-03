class Tag < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :name, presence: true
  validates :name, length: {minimum: 2}
end
