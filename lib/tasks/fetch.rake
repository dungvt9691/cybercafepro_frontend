# encoding: UTF-8

require 'csv'

namespace :events do
  def fix_encode data
    if ! data.valid_encoding?
      data = data.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    end
    data
  end
  task :fetch => :environment do
    data_file = Rails.root.join("vendor","list.csv")
    data = {}
    content = File.open(data_file, "r") do |f|
      f.read
    end
    begin
      CSV.parse(content,headers: true).each do |row|
        begin
          CustomerDb.create(cs_id: fix_encode(row['cs_id']),ip: fix_encode(row['ip']))
        rescue => e
          puts row
        end
      end
    rescue => e
    end
  end
end
