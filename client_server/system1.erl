
%%% distributed algorithms, n.dulay, 4 jan 17
%%% simple client-server, v1

%%% run all processes on one node
 
-module(system1).
-export([start/1, clients/1]).
 
start(N) ->  
  List = lists:seq(1, N),
  Clients = clients(List),
  S  = spawn(server, start, []),
  
  [X ! {bind, S} || X <- Clients],
  [S ! {bind, X} || X <- Clients].

clients(Clients) ->
  [spawn(client, start, []) || X <- Clients].
