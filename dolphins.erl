-module(dolphins).
-compile(export_all).

dolphin1() ->
    receive
        do_a_flip ->
            io:format("How about no?~n");
        fish ->
            io:format("So long and thanks for all the fish!~n");
        _ ->
            io:format("Heh, we're smarter than you humans.~n")
    end.

dolphin2 () ->
    receive
        {From, do_a_flip} ->
            From ! "How about no?";
        {From, fish} ->
            From ! "Thanks for all the fish!";
        _ -> 
            io:format("We're smarter")
    end.

dolphin3 () ->
    receive
        {From, do_a_flip} ->
            From ! "How about no?",
            dolphin3();
        {From, fish} ->
            From ! "Thanks for all the fish!";
        _ -> 
            io:format("We're smarter"),
            dolphin3()
    end.
