puts "Auctioneer loaded."
require 'dm-core'
require 'dm-migrations'

module Auctioneer
  def self.database_path path
    puts "Using #{path} "
    @database_path = path 
    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup(:default, "sqlite://#{File.expand_path(path)}")
   
    DataMapper.auto_upgrade!
  end

  class AH
    include DataMapper::Resource

    property :id, Serial
    property :name, String
  end

  DataMapper.finalize
end


