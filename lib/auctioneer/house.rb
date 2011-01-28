module Auctioneer
class House
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  has n, :tickets

  # sweep for expired auctions and handle them correctly.
  def sweep
    # for each ticket pass it to the callback.
    expired.each do |ticket|
      @after_expire.call(ticket) if @after_expire
    end
  end

  # really intended for querying for expired auctions if the callbacks are too high level.
  # If the callbacks are used *this will always be empty*.
  def expired
    all({:expiration.lte => DateTime.now})
  end

  def after_expire &blk
    @after_expire = blk
  end

  def after_complete &blk
    @after_complete = blk
  end

  def all opts
    self.tickets.all(opts)
  end
  def create_auction obj, opts
    opts[:expiration] = DateTime.now + opts[:expiration] / 24.0
    self.tickets.create(opts.merge({:item=>obj}))
  end
end

end
