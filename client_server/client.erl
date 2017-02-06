
%%% distributed algorithms, n.dulay, 4 jan 17
%%% simple client-server, v1

-module(client).
-export([start/0]).
 
start() -> 
  receive 
    {bind, S} -> next(S) 
  end.
 
next(S) ->
  S ! {rand:uniform(2), 1.0, self()},
  receive 
    {result, Area, Pid} -> 
      io:format("Area is ~p, Pid is ~p~n", [Area, Pid])
  end,
  Seconds = rand:uniform(10),
  timer:sleep(1000 * Seconds),      % pause between 1 and 10 seconds
  next(S).

