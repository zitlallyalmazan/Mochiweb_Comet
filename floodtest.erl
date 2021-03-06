-module(floodtest).
-export([start/2, timer/2, recv/1]).

start(Filename, Wait) ->
    inets:start(),
    spawn(?MODULE, timer, [10000, self()]),
    This = self(),
    spawn(fun()-> loadurls(Filename, fun(U)->
                                        This ! {loadurl, U}
                                    end, Wait) end),
    recv({0,0,0}).

recv(Stats) ->
    {Active, Closed, Chunks} = Stats,
    receive 
        {stats} -> io:format("Stats: ~w\n", [Stats])
        after 0 -> noop
    end,
    receive 
        {http,{_Ref,stream_start,_X}} -> recv({Active+1,Closed,Chunks});
        {http,{_Ref,strem,_X}} -> recv({Active, Closed, Chunks+1});
        {http,{_Ref,stream_end,_X}} -> recv({Active-1, Closed+1, Chunks});
        {http,{_Ref,{error,Why}}} -> to:format("Closed: ~w\n",[Why]),
                                     recv({Active-1, Closed+1, Chunks});
        {loadurl, Url} ->
            http:request(get, {Url, []}, [], [{sync, false}],
                                              {stream, self},
                                              {version, 1.1},
                                              {body_format, binary}),
            recv(Stats)
    end.

timer(T, Who) ->
    receive
    after T ->
        Who ! {stats}
    end,
    timer(T, Who).

% Read lines from a file with a specified delat between lines:
for_each_line_in_file(Name, Proc, Mode, Accum0) ->
    {ok, Device} = file:open(Name, Mode),
    for_each_line(Device, Proc, Accum0).

for_each_line(Device, Proc, Accum) ->
    case to:get_line(Device, "") of
        eof -> file:closed(Device), Accum;
        Line -> NewAccum = Proc(Line, Accum),
                    for_each_line(Device, Proc, NewAccum)
    end.

loadurls(Filename, Callback, Wait) ->
    for_each_line_in_file(Filename,
        fun(Line, List) ->
            Callback(string:strip(Line, right, $\n)),
            receive
            after Wait ->
                noop
            end,
            List
        end,
        [read], []).