clear();
clc();
addpath(genpath("helpers_comuns"));
%% QUANTIDADE DE PATAMARES / DISCRETIZAÇÃO TEMPORAL
nT = 3;
T  = ones(nT, 1);
%% LIMITE CAPACIDADE BATERIA
Cap = 500*T;
%% PATAMARES DE CARGA
Pd = [1.188; 2.960; 4.118];
% GERAÇÃO FOTOVOLTAICA
Pgsolar = [0; 3.5; 0];
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
aBateria = 1e-9*T;
bBateria = 0*T;
Q        = diag(intercalar(aTermica, aBateria));
b        = intercalar(bTermica, bBateria);

%% RESTRIÇÃO DE IGUALDADE
% Iaux*Pg + Pgsolar - Pd = 0
Iaux = [
    1  -1   0   0  0   0;
    0   0   1  -1  0   0;
    0   0   0   0  1  -1;
];
%% RESTRIÇÃO DESIGUALDADE
%  -Pg + Pgmin <= 0
%  Pg  - Pgmax <= 0
%  -Mat_hor*Pg <= Cap
Mat_hor = [
    0   148   0     0   0   0;
    0   148   0   428   0   0;
    0   148   0   428   0 168;
];

run
