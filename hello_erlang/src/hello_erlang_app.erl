-module(hello_erlang_app).

-behaviour(application).

-export([start/2, stop/1]).

-spec start(Type :: normal | {takeover, Node} |
		    {failover, Node},
	    Args :: term()) -> {ok, Pid :: pid()} |
			       {error, Reason :: term()}.

start(normal, Options) ->
    hello_erlang_supervisor:start_link(Options).

-spec stop(State :: term()) -> ok.

stop(_State) -> ok.
