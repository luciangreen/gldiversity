:- module(cases, [title/1, case/3]).
:- use_module('../prolog/gldiversity').
:- use_module(engine).
title('gldiversity').
words_g(Ws) :- rnd_int(1, 10, N), length(Ws, N), maplist([W]>>rnd_pick([logic, mind, time, music, idea, logic, mind], W), Ws).
case(variety, [Ws], variety) :- words_g(Ws).
case(diversify, [Ws, As], diversify) :- words_g(Ws), rnd_int(0, 4, K), findall(A, ( nth1(I, [proof, reason, algorithm, sentence], A), I =< K ), As).
