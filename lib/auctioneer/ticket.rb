module Auctioneer
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

end
