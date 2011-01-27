load '../lib/auctioneer.rb'

Auctioneer.database_path File.dirname(File.expand_path(__FILE__)) + "/auctions.db"

ah = Auctioneer::House.first_or_create(:name=>"alliance")
ah.tickets.destroy!
ah.create_auction("test", {})
ah.find_auctions("all").each {|t| puts t.item }
