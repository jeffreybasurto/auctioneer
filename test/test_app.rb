# using bundler to test here.
require 'rubygems'
require 'auctioneer'

class Item
  attr_accessor :name
  def initialize(name)
    @name = :name
  end
end

Auctioneer.database_path File.dirname(File.expand_path(__FILE__)) + "/auctions.db"

ah = Auctioneer::House.first_or_create(:name=>"alliance")

# When an auction expires yield on this block.
ah.on_expire do |ticket|
  puts "Ticket #{ticket.id} has expired."
end

ah.on_complete do |ticket|
  puts "Ticket #{ticket.id} has completed successfully."
end

#ah.tickets.destroy!
ah.create_auction(Item.new("fancy bracelet"), {:owner=>"Jeffrey Basurto", :current_bid=>50, :expiration=>24})
ah.create_auction(Item.new("crown"),  {:owner=>"Jeffrey Basurto", :current_bid=>70, :expiration=>1})
ah.create_auction(Item.new("red fedora"), {:owner=>"Jonathan", :expiration=>0})
ah.create_auction(Item.new("red fedora"), {:owner=>"Jonathan", :expiration=>0})
ah.create_auction(Item.new("red fedora"), {:owner=>"Jonathan", :expiration=>0})

# query for all of Jefffrey Basurto's auctions that the current bid is at more than 60.
ah.all({:owner=>"Jeffrey Basurto".to_yaml, :current_bid.gt=>60}).each {|t| puts "Item: #{t.item.name}  Owner: #{t.owner}" }

ah.sweep
