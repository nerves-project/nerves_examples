-module(hello_erlang_app).

-behaviour(application).

-export([start/2, stop/1]).

start(normal, Options) ->
    hello_erlang_supervisor:start_link(Options).

stop(_State) -> ok.
