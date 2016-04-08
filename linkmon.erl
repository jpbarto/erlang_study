-module(linkmon).

-compile(export_all).

myproc () ->
    timer:sleep(5000),
    exit(reason).

chain(0) ->
    receive
        _ -> ok
    after 2000 ->
        exit("chain dies here")
    end;
chain(N) ->
    Pid = spawn(fun() -> chain(N-1) end),
    link(Pid),
    receive
        _ -> ok
    end.

start_critic () ->
    spawn(?MODULE, critic, []).

start_critic2 () ->
    spawn(?MODULE, restarter, []).

restarter () ->
    process_flag(trap_exit, true),
    Pid = spawn_link(?MODULE, critic2, []),
    register(critic, Pid),
    receive
        {'EXIT', Pid, normal} -> % not a crash
            ok;
        {'EXIT', Pid, shutdown} -> % manual termination, not a crash
            ok;
        {'EXIT', Pid, _} ->
            restarter ()
    end.

judge (Pid, Band, Album) ->
    Pid ! {self(), {Band, Album}},
    receive
        {Pid, Criticism} -> Criticism
    after 2000 ->
        timeout
    end.

judge2(Band, Album) ->
    Ref = make_ref(),
    critic ! {self(), Ref, {Band, Album}},
    receive
        {Ref, Criticism} -> Criticism
    after 2000 ->
        timeout
    end.

critic () ->
    receive
        {From, {"ratm", "unit test"}} ->
            From ! {self(), "good stuff"};
        {From, {"sod", "oh yeah"}} ->
            From ! {self(), "they're alright"};
        {From, {"jc", "the boys"}} ->
            From ! {self(), "now you're talking"};
        {From, {_Band, _Album}} ->
            From ! {self(), "Never heard of them"}
    end,
    critic ().

critic2 () ->
    receive
        {From, Ref, {"ratm", "unit test"}} ->
            From ! {Ref, "good stuff"};
        {From, Ref, {"sod", "oh yeah"}} ->
            From ! {Ref, "they're alright"};
        {From, Ref, {"jc", "the boys"}} ->
            From ! {Ref, "now you're talking"};
        {From, Ref, {_Band, _Album}} ->
            From ! {Ref, "Never heard of them"}
    end,
    critic2 ().
