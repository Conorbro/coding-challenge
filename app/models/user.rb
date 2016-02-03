class User < ActiveRecord::Base
  require 'csv'

  validates :name, presence: true,
                   length: {minimum: 2}
  validates :email, presence: true,
                    length: {minimum: 5}
  validates :email, uniqueness: true # Not part of the challenege but I feel it makes sense not to have duplicate users!

  def self.import(file)
    unless file == nil
      CSV.foreach(file.path, :headers => true) do |csv_obj|
        name = csv_obj[0]
        email = csv_obj[1]
        user = createUser(name, email)
        createTags(csv_obj, user)
      end
    end
  end

  def self.createTags(csv_obj, user)
    csv_obj.each_with_index {|item, index|
      unless index==0 || index==1 || item[1].class!=String
        tag = Tag.create(name: item[1])
        if(tag.id == nil)
          tag = Tag.where(:name => item[1]).first
        end
        if(user.id != nil && tag != nil)
          userTag = associateUserTag(tag.id, user.id)
        end
      end
    }
  end

  def self.createUser(name, email)
    return User.create(name: name, email: email)
  end

  def self.associateUserTag(tag_id, user_id)
    return UserTag.create(tag_id: tag_id, user_id: user_id)
  end

end
