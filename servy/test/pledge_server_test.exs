defmodule PledgeServerTest do
  use ExUnit.Case

  alias Servy.PledgeServer

  test "caches the 3 most recent pledges and totals their amounts" do
    PledgeServer.start()

    PledgeServer.create_pledge("larry", 10)
    PledgeServer.create_pledge("moe", 20)
    PledgeServer.create_pledge("curly", 30)
    PledgeServer.create_pledge("daisy", 40)
    PledgeServer.create_pledge("grace", 50)

    most_recent_pledges = [{"grace", 50}, {"daisy", 40}, {"curly", 30}]
    assert PledgeServer.recent_pledges() == most_recent_pledges
    assert PledgeServer.total_pledged == 120

    PledgeServer.clear()
    assert PledgeServer.recent_pledges() == []
  end

  test "sets the cache size" do
    PledgeServer.start()

    PledgeServer.set_cache_size(2)
    PledgeServer.create_pledge("larry", 10)
    PledgeServer.create_pledge("moe", 20)
    PledgeServer.create_pledge("curly", 30)
    PledgeServer.create_pledge("daisy", 40)
    PledgeServer.create_pledge("grace", 50)

    most_recent_pledges = [{"grace", 50}, {"daisy", 40}]
    assert PledgeServer.recent_pledges() == most_recent_pledges
  end
end