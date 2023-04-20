% Define the initial state of the problem
initial_state(state(left, left, left, left)).

% Define the goal state of the problem
goal_state(state(right, right, right, right)).

% Define the legal moves for the problem
move(state(X, X, G, Y), state(Y, Y, G, Y)) :- opposite(X, Y).
move(state(X, W, X, Y), state(Y, W, Y, Y)) :- opposite(X, Y).
move(state(X, W, G, X), state(Y, W, G, Y)) :- opposite(X, Y).
move(state(X, W, G, Y), state(Y, W, G, Y)) :- opposite(X, Y).

% Define the opposite river banks
opposite(left, right).
opposite(right, left).

% Define the heuristic function for the A* algorithm
heuristic(state(X, W, G, C), H) :-
    (W = C; G = C), !,
    H is 2.
heuristic(_, H) :-
    H is 1.

% Define the A* search algorithm
a_star(Start, Path) :-
    heuristic(Start, H),
    a_star([[Start, [], 0, H]], [], Path).

a_star([[State, Path, G, H] | _], _, Path) :-
    goal_state(State), !.
a_star([[State, Path, G, H] | Rest], Closed, Soln) :-
    findall([S, [Move | Path], G1, H1], (move(State, S), \+ member([S, _, _, _], Closed), G1 is G+1, heuristic(S, H1)), Children),
    append(Children, Rest, Queue),
    sort(Queue, Queue1),
    a_star(Queue1, [[State, Path, G, H] | Closed], Soln).
