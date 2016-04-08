-module(useless).

-export([add/2, hello/0, greet_and_add/1, greet/2, wrong_age/1, right_age/1, fac/1, list_len/1, tail_fac/1, tail_list_len/1, duplicate/2, tail_duplicate/2, reverse/1, tail_reverse/1, sublist/2, tail_sublist/2]).

-define(sub(X,Y), X-Y).

add(A,B) ->
    A + B.

% Say hello
hello() ->
    io:format("Hello, World!~n").

greet_and_add (X) ->
    hello (), 
    add(X, 2).

greet (male, Name) ->
    io:format ("Hello, Mr. ~s!", [Name]);

greet (female, Name) ->
    io:format ("Hello, Mrs. ~s!", [Name]);

greet (_, Name) ->
    io:format ("Hello there, ~s!", [Name]).

right_age (X) when X >= 16, X < 104 ->
    true;
right_age (_) -> 
    false.

wrong_age (X) when X < 16; X >= 104 ->
    true;
wrong_age (_) -> 
    false.

fac(0) -> 1;
fac(N) when N > 0 -> N*fac(N-1).

tail_fac(N) -> tail_fac(N,1).
tail_fac(0,Acc) -> Acc;
tail_fac(N,Acc) when N > 0 -> tail_fac(N-1, N*Acc).

list_len([]) -> 0;
list_len([_|T]) -> 1 + list_len(T).

tail_list_len (L) -> tail_list_len (L, 0).
tail_list_len([], Acc) -> Acc;
tail_list_len([_|T], Acc) -> tail_list_len(T, 1 + Acc).

duplicate (0, _) -> [];
duplicate (C, E) when C > 0 -> [E|duplicate (C-1, E)].

tail_duplicate (C, E) -> tail_duplicate (C, E, []).
tail_duplicate (0, _, L) -> L;
tail_duplicate (C, E, L) when C > 0 -> tail_duplicate (C-1, E, [E|L]).

reverse([]) -> [];
reverse([Head|Tail]) -> reverse(Tail)++[Head].

tail_reverse(List) -> tail_reverse(List, []).
tail_reverse([], List) -> List;
tail_reverse([Head|Tail], List) -> tail_reverse(Tail, [Head|List]).

sublist(_, 0) -> [];
sublist([], _) -> [];
sublist([Head|Tail], C) when C > 0 -> [Head]++sublist(Tail, C-1).

tail_sublist (List, C) -> tail_sublist (List, C, []).
tail_sublist (_, 0, Acc) -> Acc;
tail_sublist ([], _, Acc) -> Acc;
tail_sublist ([Head|Tail], C, Acc) when C > 0 -> reverse(tail_sublist(Tail, C-1, [Head|Acc])).
