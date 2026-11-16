# gldiversity

measure how varied Grammar Logic output is, and make it more varied. Variety is the number of distinct words and the number of distinct word pairs in a row; diversify keeps the first word (GL copies the topic's first word) and the length, and replaces each repeat with an unused word from a list of alternatives, so variety never goes down.

## Use

```prolog
?- use_module(prolog/gldiversity).
?- variety([logic, mind, logic, mind], V).              % V = variety(2, 2)
?- diversify([logic, mind, logic, mind], [idea, reason, proof], D).   % D = [logic, mind, idea, reason]
```

## Proofs

`proofs/theorems.pl` proves 4 theorems by exhaustion: each one is checked for every case in a finite domain that covers every branch of the definitions. every word list of length 1..4 over a, b, c, with alternatives from x, y.

1. Diversifying never lowers either measure of variety.
2. It keeps the first word and the length.
3. With enough alternatives, every word ends up different.
4. The measures are bounded: distinct words at most the length, distinct pairs at most the length minus one.

```sh
swipl -g main -t halt proofs/theorems.pl
```

## 200 inputs and outputs

`io/ios.txt` lists 200 inputs and outputs from real runs, and `io/ios.pl` has the same as Prolog facts. The inputs come from a fixed seed (`io/cases.pl`). `swipl -g check -t halt io/run.pl` runs them again. It fails if any output changes, or if a predicate doesn't confirm its own recorded output, which checks steadfastness. GitHub Actions runs the proofs and the examples on every push, and records the examples on the first push.

Licence: BSD-3-Clause.
