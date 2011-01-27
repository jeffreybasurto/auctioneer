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

  class House
    include DataMapper::Resource

    property :id, Serial
    property :name, String

    has n, :tickets
  end
  # data for an individual auction.
  class Ticket
    belongs_to :ah
  end

  DataMapper.finalize
end


