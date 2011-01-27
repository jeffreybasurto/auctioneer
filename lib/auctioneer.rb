puts "Auctioneer loaded."
require 'dm-core'
require 'dm-migrations'
require 'yaml'

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

    def find opts
      self.tickets.all(opts)
    end

    def create_auction obj, opts
      
      self.tickets.create(opts.merge({:item=>obj}))
    end
  end
  # data for an individual auction.
  class Ticket
    include DataMapper::Resource
    property :id, Serial

    property :item, String
    property :expiration, DateTime
    property :buy_now, Integer

    property :owner, String
    property :winner, String
    property :current_bid, Integer

    
    def winner=(obj)
      super YAML.dump(obj)
    end
    def winner
      YAML.load(super) rescue nil
    end
    def owner=(obj)
      super YAML.dump(obj)
    end
    def owner
      YAML.load(super) rescue nil
    end

    def item=(obj)
      super YAML.dump(obj)
    end
    def item
      YAML.load(super) rescue nil
    end



    belongs_to :house
  end

  DataMapper.finalize
end


