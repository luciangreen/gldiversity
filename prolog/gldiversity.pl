% gldiversity: measure how varied Grammar Logic output is, and make it more varied. Variety is
% the number of distinct words and the number of distinct word pairs in a row; diversify keeps
% the first word (GL copies the topic's first word) and the length, and replaces each repeat
% with an unused word from a list of alternatives, so variety never goes down.
%?- variety([logic, mind, logic, mind], V).              % V = variety(2, 2)
%?- diversify([logic, mind, logic, mind], [idea, reason, proof], D).   % D = [logic, mind, idea, reason]
:- module(gldiversity, [variety/2, distinct/2, pairs_distinct/2, diversify/3]).
:- use_module(library(lists)).
:- use_module(library(apply)).

distinct(Ws, N) :- sort(Ws, S), length(S, N).
pairs_distinct(Ws, N) :- findall(A-B, nextto(A, B, Ws), Ps), sort(Ps, S), length(S, N).
variety(Ws, variety(D, P)) :- distinct(Ws, D), pairs_distinct(Ws, P).

% diversify(+Words, +Alternatives, -Words2): later repeats become the first alternative not yet used.
diversify([], _, []).
diversify([W|Ws], Alts, [W|Out]) :- foldl([X, Seen-Acc, Seen2-[Y|Acc]]>>( memberchk(X, Seen), member(Y, Alts), \+ memberchk(Y, Seen) -> Seen2 = [Y|Seen] ; Y = X, Seen2 = [X|Seen] ), Ws, [W]-[], _-Rev), reverse(Rev, Out).
