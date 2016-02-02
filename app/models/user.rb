class User < ActiveRecord::Base
  require 'csv'

  validates :name, presence: true,
                   length: {minimum: 2}
  validates :email, presence: true,
                    length: {minimum: 5}

  def self.import(file)
    counter = 0
    CSV.foreach(file.path) do |row|
      print row
      name = row[0]
      email = row[1]

      user = User.create(name: name, email: email)
      puts user.errors.full_messages if user.errors.any?
      counter += 1 if user.persisted?

      row.each { |tags|
        unless row.index(tags) == 0 || row.index(tags) == 1
          tag = Tag.create(name: tags)
          puts tag.id
          userTag = UserTag.create(tag_id: tag.id, user_id: user.id)
          puts userTag.errors.full_messages if userTag.errors.any?
        end
      }
    end
  end
end
