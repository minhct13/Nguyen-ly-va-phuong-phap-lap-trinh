initial_state(s(0, 0, 0, 0)).
goal_state(s(1,1,1,1)).
/* A state in which the sheep is left with the bean or the wolf
while the farmer is on the opposite side
* is not a safe state.
* East and West are opposite sides.
*/
opp(1, 0).
opp(0, 1).
/*
equal(X,X).
*/
unsafe(s(W, B, S, F)) :-
opp(F, S),
( equal(S, B) ; % semicolon indicates "or" - alternate possibilities.
equal(S, W)).
/* A state is safe if it is not unsafe */
safe(S) :- not(unsafe(S)).
move(s(W, B, S, F), s(W, B, S, F1), A):-
opp(F, F1),
safe(s(W, B, S, F1)),
A='Farmer rows alone from'-F-to-F1.
move(s(W, B, S, S), s(W, B, S1, S1), A):-
opp(S, S1),
safe(s(W, B, S1, S1)),
A='Farmer takes sheep from'-S-to-S1.
move(s(W, B, S, B), s(W, B1, S, B1), A):-
opp(B, B1),
safe(s(W, B1, S, B1)),
A='Farmer takes bean from'-B-to-B1.
move(s(W, B, S, W), s(W1, B, S, W1), A):-
opp(W, W1),
safe(s(W1, B, S, W1)),
A='Farmer takes wolf from'-W-to-W1.
children(Cs, Nss):- bagof(Ns, A^move(Cs, Ns, A), Nss).
bfs([Path|_Other_Paths], Gs, FP):-
equal(Path, [Gs|_]),
reverse(Path, FP).
/*To find the optimum path*/
bfs([Path|Other_paths], Gs, FP):-
equal(Path, [Gs|_]),
bfs(Other_paths, Gs, FP).
bfs([Path|Other_paths], Gs, FP):-
equal(Path, [Cs|_P]), not(equal(Cs, Gs)),
extend_path(Path, Paths),
append(Other_paths, Paths, New_paths),
bfs(New_paths, Gs, FP).
extend_path([Cs|RPath],Extndd_paths):-
children(Cs, LCs),!,
extnd_pth(LCs, [Cs|RPath], [], Extndd_paths).
extend_path(_, []).
extnd_pth([C|RLcs], Path, Paths, Extndd_paths):-
( not(member(C, Path))->
append(Paths, [[C|Path]], Extended_paths_C); equal(Extended_paths_C, Paths)),
extnd_pth(RLcs, Path, Extended_paths_C, Extndd_paths).
extnd_pth([],_,P, P).
equal(_1, _1).
run_bfs(Is, Gs, Path):-
write(["input state", Is, "output state", Gs]),
bfs([[Is]], Gs, Path).