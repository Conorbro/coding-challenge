require 'csv'

namespace :import do

  desc "Import data from csv"
  task users: :environment do
    filename = File.join Rails.root, "data.csv"
    counter = 0

    CSV.foreach(filename) do |row|
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

    puts "Data imported #{counter}"
  end
end
