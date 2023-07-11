%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%     Cálculo de alfap e alfad
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% alfap
%
s         = [spmin; spmax];
deltas    = [deltaspmin; deltaspmax];
deltasneg = find(deltas<0.0);
dels      = deltas(deltasneg,:);
d         = s(deltasneg,:);
auxalf    = -d./dels;
alfap     = [min(auxalf) 1];
alfap     = min(alfap);
%
%
%  alfad
%
pi         = [pipmin; pipmax];
deltapi    = [deltapipmin; deltapipmax];
deltapineg = find(deltapi<0.0);
beta2      = -(pi(deltapineg,:)./deltapi(deltapineg,:));
alfad      = [ beta2; 1];
alfad      = min(alfad);
