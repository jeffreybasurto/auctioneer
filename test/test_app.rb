load '../lib/auctioneer.rb'

Auctioneer.database_path File.dirname(File.expand_path(__FILE__)) + "/auctions.db"

ah = Auctioneer::AH.first_or_new(:name=>"alliance")

puts ah.class
ah.save
