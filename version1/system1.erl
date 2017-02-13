
%%% distributed algorithms, n.dulay, 4 jan 17
%%% simple client-server, v1

%%% run all processes on one node
 
-module(system1).
-export([start/0, peers/1]).
 
start() ->  
  Ps = lists:seq(1, 10),
  Peers = peers(Ps),
  [X ! {bind, lists:delete(X, Peers)} || X <- Peers],
  
  hd(Peers) ! hello.

peers(Ps) ->
  [spawn(peer, start, []) || X <- Ps].
