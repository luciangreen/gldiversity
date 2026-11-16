% Theorems, proved by exhaustion. Run: swipl -g main -t halt proofs/theorems.pl
:- module(theorems, [main/0]).
:- use_module(prove).
:- discontiguous theorem/1.
:- use_module(library(lists)).
:- use_module(library(apply)).
main :- prove_all(theorems).
:- use_module('../prolog/gldiversity').

% Domain: every word list of length 1..4 over a, b, c, with alternatives from x, y.
words(Ws) :- between(1, 4, N), length(Ws, N), maplist([W]>>member(W, [a, b, c]), Ws).
alts(As) :- member(As, [[], [x], [x, y]]).

% 1. Diversifying never lowers either measure of variety.
theorem(diversify_never_less_varied) :- forall(( words(Ws), alts(As) ), ( diversify(Ws, As, D), variety(Ws, variety(D1, P1)), variety(D, variety(D2, P2)), D2 >= D1, P2 >= P1 )).

% 2. It keeps the first word and the length.
theorem(keeps_first_and_length) :- forall(( words(Ws), alts(As) ), ( diversify(Ws, As, D), Ws = [F|_], D = [F|_], length(Ws, N), length(D, N) )).

% 3. With enough alternatives, every word ends up different.
theorem(enough_alternatives_all_distinct) :- forall(words(Ws), ( length(Ws, N), numlist(1, N, Is), maplist([I, A]>>atom_concat(alt, I, A), Is, As), diversify(Ws, As, D), distinct(D, N) )).

% 4. The measures are bounded: distinct words at most the length, distinct pairs at most the length minus one.
theorem(measures_bounded) :- forall(words(Ws), ( variety(Ws, variety(D, P)), length(Ws, N), D =< N, D >= 1, P =< N - 1 )).
