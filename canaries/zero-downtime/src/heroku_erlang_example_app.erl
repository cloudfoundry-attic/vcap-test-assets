%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc Callbacks for the heroku_erlang_example application.

-module(heroku_erlang_example_app).
-author('author <author@example.com>').

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for heroku_erlang_example.
start(_Type, _StartArgs) ->
    heroku_erlang_example_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for heroku_erlang_example.
stop(_State) ->
    ok.
