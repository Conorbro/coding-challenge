class User < ActiveRecord::Base
  require 'csv'

  validates :name, presence: true,
                   length: {minimum: 2}
  validates :email, presence: true,
                    length: {minimum: 5}

  def self.import(file)
    CSV.foreach(file.path) do |row|
      name = row[0]
      email = row[1]

      user = User.create(name: name, email: email)
      puts user.errors.full_messages if user.errors.any?

      row.each { |tags|
        unless row.index(tags) == 0 || row.index(tags) == 1
          tag = Tag.create(name: tags)
          # if tag.id is black then query model for the id of that tag
          # Get id of row from Tag
          if(tag.id == nil)
            tag = Tag.where(:name => tags).first
          end
          userTag = UserTag.create(tag_id: tag.id, user_id: user.id)
          puts userTag.errors.full_messages if userTag.errors.any?
        end
      }
    end
  end
end
