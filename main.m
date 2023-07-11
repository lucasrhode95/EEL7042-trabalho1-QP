clear();
clc();
addpath(genpath("helpers_comuns"));

nT = 3;
T  = ones(nT, 1);

%% LIMITE CAPACIDADE BATERIA
Cap = 500*T;
%% PATAMARES DE CARGA
Pd = [1.188; 2.960; 4.118];
%% LIMITE DE POTÊNCIA MÁXIMA
maxTermica = 7*T;
maxBateria = 3*T;
Pgmax      = intercalar(maxTermica, maxBateria);
%% LIMITE DE POTÊNCIA MÍNIMA
minTermica = 0*T;
minBateria = -3*T;
Pgmin      = intercalar(minTermica, minBateria);
%% CUSTOS DE GERAÇÃO
aTermica = 5*T;
bTermica = 2*T;
aBateria = 0*T;
bBateria = 0*T;
Q        = diag(intercalar(aTermica, aBateria));
b        = intercalar(bTermica, bBateria);





%% CHUTE INICIAL
Pg = (Pgmax + Pgmin)/2
