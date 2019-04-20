-module(hello_erlang_worker).

-behaviour(gen_server).

-export([code_change/3, handle_call/3, handle_cast/2,
	 handle_info/2, init/1, start_link/0, terminate/2]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [],
			  []).

init(_Args) -> hello_me(), {ok, nostate}.

handle_call(_What, _From, State) -> {reply, ok, State}.

handle_cast(_What, State) -> {noreply, State}.

handle_info(hello, State) ->
    hello_me(), {noreply, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVersion, State, _Extra) -> {ok, State}.

hello_me() ->
    io:format("Hello!~n"),
    erlang:send_after(5000, erlang:self(), hello).
