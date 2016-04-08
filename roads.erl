-module(roads).
-compile(export_all).

main ([Filename]) ->
    {ok, BData} = file:read_file (Filename),
    Map = parse_map (BData),
    io:format("~p~n", [optimal_path(Map)]),
    erlang:halt().

erl_main () ->
    Filename = "roads.txt",
    {ok, BData} = file:read_file (Filename),
    optimal_path (parse_map(BData)).

parse_map(Streets) when is_binary(Streets) ->
    parse_map(binary_to_list(Streets));
parse_map(Streets) when is_list(Streets) ->
    Values = [list_to_integer(X) || X <- string:tokens(Streets, "\r\n\t")],
    group_vals(Values, []).

group_vals([], Acc) ->
    lists:reverse (Acc);
group_vals([A,B,X|Rest], Acc) ->
    group_vals(Rest, [{A,B,X}|Acc]).

shortest_step({A,B,X}, {{DistA, PathA}, {DistB, PathB}}) ->
    OptA1 = {DistA + A, [{a,A}|PathA]},
    OptA2 = {DistB + B + X, [{x,X}, {b,B}|PathB]},
    OptB1 = {DistB + B, [{b,B}|PathB]},
    OptB2 = {DistA + A + X, [{x,X}, {a,A}|PathA]},
    {erlang:min(OptA1, OptA2), erlang:min(OptB1, OptB2)}.

optimal_path(Map) ->
    {A,B} = lists:foldl(fun shortest_step/2, {{0,[]}, {0,[]}}, Map),
    {_Dist, Path} = if hd(element(2,A)) =/= {x,0} -> A;
                        hd(element(2,B)) =/= {x,0} -> B
                    end,
    lists:reverse(Path).
