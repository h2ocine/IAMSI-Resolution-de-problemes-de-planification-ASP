%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% PLANIFICATEUR ASP-STRIPS %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#const n=4. % Nombre d"etapes

time(0..n).

% Etat initial : si quelque chose est initialement vrai, il est vrai au temps 0.
holds(P,0) :- init(P).

1 { perform(A,T) : action(A) } 1 :- time(T), T < n.

% precond : une action ne peut se produire que si toutes les conditions sont vÃ©rifiÃ©es.
:- perform(A,T), not holds(P,T), pre(A,P), action(A), pred(P), time(T).

% Effets positifs : si une action s'effectue au temps T, tous ses effets sont vrais au temps T+1.
holds(P,T+1) :- perform(A,T), add(A,P), action(A), pred(P), time(T).

% Inertie et effets negatifs : ce qui est vrai au temps T est vrai au temps T+1, sauf si une action y a mis fin.
holds(P,T+1) :- holds(P,T), not del(A,P), perform(A,T), action(A), pred(P), time(T).

% Choix d'action : une seule action est effectuÃ©e Ã  chaque pas de temps.
:- perform(A1,T), perform(A2,T), action(A1), action(A2), A1 != A2, time(T).

% SpÃ©cification du but : le but doit Ãªtre atteint au temps n.
:- not holds(P,n), but(P), pred(P).


#show perform/2.