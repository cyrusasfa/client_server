-module(peer).
-export([start/0]).

start() ->
  receive
    {bind, LIST} -> next(0, LIST)
  end.

next(N, Peers) ->
  if
    N == 0 ->
      receive
        {hello} -> [P ! {hello} || P <- Peers]
      after 1000 ->
        io:format("Peer ~p received ~p~n messages", [self(), N])
      end,
      N1 = N + 1;
    N >= 1 ->
      N1 = N + 1
  end,
    io:format("Peer ~p received ~p~n messages", [self(), N1]),
    timer:sleep(rand:uniform(10)),
    next(N1, Peers).
