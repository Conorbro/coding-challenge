class UserTag < ActiveRecord::Base
  validates :tag_id, uniqueness: true
end
