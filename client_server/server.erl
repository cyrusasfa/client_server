
%%% distributed algorithms, n.dulay, 4 jan 17
%%% simple client-server, v1

-module(server).
-export([start/0]).
 
start() ->  
  receive 
    {bind, C} -> next() 
  end.
 
next() ->
  receive
    {1, Radius, Pid} ->  Pid ! {result, 3.14159 * Radius * Radius, Pid};
    {2, Side, Pid}   ->  Pid ! {result, Side * Side, Pid}
  end,
  next().

