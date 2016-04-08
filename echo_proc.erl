-module (echo_proc).
-export ([go/0, loop/0, thread/0]).

go () ->
	Pid2 = spawn (echo_proc, loop, []),
	Pid2 ! {self(), hello},
	receive
		{Pid2, Msg} ->
			io:format ("P1 ~w~n", [Msg])
	end,
	Pid2 ! stop.

loop () ->
	receive
		{From, Msg} ->
			From ! {self(), Msg},
			loop();
		stop ->
			true
	end.

thread () ->
	receive 
		{From, Msg} ->
			io:format ("thread ~w ~w~n", [self(), Msg]),
			From ! {self(), Msg},
			thread ();
		stop ->
			true
	end.
