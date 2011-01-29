module Auctioneer
  class House
    include DataMapper::Resource

    property :id, Serial
    property :name, String

    has n, :tickets

    # sweep for expired auctions and handle them correctly.
    def sweep
      # for each ticket pass it to the callback.
      found = expired
      found.each do |ticket|
        @on_expire.call(ticket) if @on_expire && ticket.expired?
        @on_complete.call(ticket) if @on_complete && ticket.completed?
      end
      # one destroy statement for everything found.
      found.destroy!
    end

    # really intended for querying for expired auctions if the callbacks are too high level.
    # If the callbacks are used *this will always be empty*.
    def expired
      all({:expiration.lte => DateTime.now})
    end

    def on_expire &blk
      @on_expire = blk
    end

    def on_complete &blk
      @on_complete = blk
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

