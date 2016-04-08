-module(mstuff).
-export([factorial/1, area/1]).

factorial(0) -> 1;
factorial(N) -> N * factorial (N-1).

area({sq, Side}) -> Side * Side;
area({circle, Radius}) -> 3.14159 * Radius * Radius;
area(Other) -> {invalid_object, Other}.
