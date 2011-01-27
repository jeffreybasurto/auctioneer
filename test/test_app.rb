load '../lib/auctioneer.rb'

class Item
  attr_accessor :name
  def initialize(name)
    @name = :name
  end
end

Auctioneer.database_path File.dirname(File.expand_path(__FILE__)) + "/auctions.db"

ah = Auctioneer::House.first_or_create(:name=>"alliance")
ah.tickets.destroy!
ah.create_auction(Item.new("fancy bracelet"), {:owner=>"Jeffrey Basurto", :current_bid=>50})
ah.create_auction(Item.new("crown"),  {:owner=>"Jeffrey Basurto", :current_bid=>70})
ah.create_auction(Item.new("red fedora"), {:owner=>"Jonathan"})
ah.find({:owner=>"Jeffrey Basurto".to_yaml, :current_bid.gt=>60}).each {|t| puts "Item: #{t.item.name}  Owner: #{t.owner}" }
