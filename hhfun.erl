-module(hhfun).
-export([one/0, two/0, add/2, increment/1, decrement/1, incr/1, decr/1, map/2]).

one() -> 1.
two() -> 2.
add(X,Y) -> X() + Y().

increment([]) -> [];
increment([H|T]) -> [H+1|increment(T)].

decrement([]) -> [];
decrement([H|T]) -> [H-1|decrement(T)].

map(_, []) -> [];
map(Func, [H|T]) -> [Func(H)|map(Func,T)].

incr(X) -> X + 1.
decr(X) -> X - 1.
