
%%% distributed algorithms, n.dulay, 4 jan 17
%%% simple client-server, v1

%%% run all processes on one node

-module(system2).
-export([start/0, peers/1]).
-on_load(start/0).

start() ->
  Ps = lists:seq(1, 10),
  Peers = peers(Ps),
  [X ! {bind, lists:delete(X, Peers)} || X <- Peers],
  list:nth(1, Peers) ! {bind, [lists:nth(2, Peers), lists:nth(7, Peers)]},
  list:nth(2, Peers) ! {bind, [lists:nth(1, Peers), lists:nth(3, Peers), lists:nth(4, Peers)]},
  list:nth(3, Peers) ! {bind, [lists:nth(2, Peers), lists:nth(4, Peers), lists:nth(5, Peers)]},
  list:nth(4, Peers) ! {bind, [lists:nth(2, Peers), lists:nth(3, Peers), lists:nth(6, Peers)]},
  list:nth(5, Peers) ! {bind, [lists:nth(3, Peers)]},
  list:nth(6, Peers) ! {bind, [lists:nth(4, Peers)]},
  list:nth(7, Peers) ! {bind, [lists:nth(1, Peers), lists:nth(8, Peers)]},
  list:nth(8, Peers) ! {bind, [lists:nth(7, Peers), lists:nth(9, Peers), lists:nth(10, Peers)]},
  list:nth(9, Peers) ! {bind, [lists:nth(8, Peers), lists:nth(10, Peers)]},
  list:nth(10, Peers) ! {bind, [lists:nth(8, Peers), lists:nth(9, Peers)]},

  hd(Peers) ! hello.

peers(Ps) ->
  [spawn(peer, start, []) || _ <- Ps].
