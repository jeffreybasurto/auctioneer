puts "Auctioneer loaded."
require 'dm-core'
require 'dm-migrations'
require 'yaml'

module Auctioneer
  require 'auctioneer/timers.rb'
  require 'auctioneer/house.rb'
  require 'auctioneer/ticket.rb'
  DataMapper.finalize # finalize the models

  def self.database_path path
    puts "Using #{path}."
    @database_path = path 
    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup(:default, "sqlite://#{File.expand_path(path)}")
   
    DataMapper.auto_upgrade!
  end
end
