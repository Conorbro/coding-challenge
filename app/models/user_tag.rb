class UserTag < ActiveRecord::Base
  # validates :tag_id, uniqueness: true
  # validates :tag_id, uniqueness: {scope: :user_id}
end
