# For testing importing of data from CSV file

require 'csv'

namespace :import do

  desc "Import data from csv"
  task users: :environment do
    filename = File.join Rails.root, "data.csv"
    counter = 0

    CSV.foreach(filename, :headers => true) do |csv_obj|

      name = csv_obj[0]
      email = csv_obj[1]
      user = User.create(name: name, email: email)
      counter += 1 if user.persisted?

      csv_obj.each_with_index {|item, index|
        unless index==0 || index==1 || item[1].class!=String
          tag = Tag.create(name: item[1])
          if(tag.id == nil)
            tag = Tag.where(:name => item[1]).first
          end
          userTag = UserTag.create(tag_id: tag.id, user_id: user.id)
        end
      }
      end
  end
end
