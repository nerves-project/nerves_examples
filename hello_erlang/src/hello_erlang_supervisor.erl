-module(hello_erlang_supervisor).

-behaviour(supervisor).

-export([init/1, start_link/1]).

start_link(Options) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE,
			  Options).

init(_Options) ->
    Flags = {one_for_one, 1000, 3600},
    Specs = [{hello_erlang_worker,
	      {hello_erlang_worker, start_link, []}, permanent, 2000,
	      worker, [hello_erlang_worker]}],
    {ok, {Flags, Specs}}.
