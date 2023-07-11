%%         Formulação do despacho Econômico  pelo
%         Método Primal-Dual de Pontos Interiores

%%
%   ng: número de barras
%   Pg: vetor das potências geradas ( ng)
%   Pd: vetor das cargas
%   Pgmin: vetor dos limites de geração inferior ( ng,1)
%   Pgmax: vetor dos limites de geração superior ( ng,1)
%   spmin: var. de folga para restrição de lim. mín. de pot. nas barras de geração(ng)
%   spmax: var. de folga para restrição de lim. máx. de pot. nas barras de geração(ng)
%   Variáveis Primais: Pg,spmin,spmax
%   Variáveis duais: lambda,pipmax, pipmin ( Multiplicadores de Lagrange)
%   Parâmetro da barreira logaritmica: mi
%
format long g;
clear all

%---------------------------------------------------------
%- Main Program
%---------------------------------------------------------
disp('  ')
disp('  ')

 %          Dados de Barra
 %    Pgmin     Pgmax    a       b      c

BAR=[
    0    400    0.009   80  140;
    10   400    0.008   90  100;
    0    400    0.008   70   90;
    0    300    0       80  100;
];

ng=4;
Pd=400;

wc    = 1;
mi    = 0.1;
tol   = 1e-6;
Pgmin = BAR(:,1);
Pgmax = BAR(:,2);
a     = BAR(:,3);  % coeficiente quadrático
b     = BAR(:,4);
c     = BAR(:,5);

%       Impressão dos Dados de Barra
delete saida.out
diary saida.out
format;
%   Matriz de coeficintes quadráticos

Q = diag(a);
Q = 2*Q;

%     Inicialização das variáveis primais
k     = 0;
Pg    = (Pgmax+Pgmin)/2;
spmin = Pg-Pgmin;
spmax = Pgmax-Pg;

%    Matrizes Diagonais de variáveis de folga
Spmin = diag(spmin);
Spmax = diag(spmax);
e     = ones(ng,1);

%    Inicialização das variáveis duais
lambda = 1;
pipmin = mi * (Spmin\e);
pipmax = mi * (Spmax\e);

%  Agrupamento das variáveis do problema no vetor Z
Z  = [Pg' spmin' spmax' lambda pipmin' pipmax'];
Z  = Z';
Zp = [Pg' spmin' spmax'];
Zp = Zp';
Zd = [lambda pipmin' pipmax'];
Zd = Zd';
nd = size(Zd,1);
np = size(Zp,1);
nz = size(Z,1);

COND_KKT  % Cálculo das condições de otimalidade para valores iniciais
normainf = norm(deltaL);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Loop Principal
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while normainf>=tol
    if k > 200
       break;
    end

    k      = k+1;
    FormaW;
    deltaZ = -(W\deltaL);

    SEPARADeltaZ;
    ALFA

    %   Atualização
    Zp = Zp+(.9995*alfap)*deltaZp;
    Zd = Zd+(0.995*alfad)*deltaZd;
    Z  = [Zp; Zd];

    SEPARAZ

    s  = [spmin; spmax];
    pi = [pipmin; pipmax];
    mi = pi'*s;
    mi = (pi'* s)/(2*nz*10);


    COND_KKT  % Chama rotina que calcula  condições de otimalidade
    normainf = norm(deltaL)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if k==201
    disp('não houve convergência em 100 iterações');
else
    % Cálculo do custo total do despacho
    Ct = 0;
    Ci = 0;
    for I=1:ng
       C(I)  = a(I)* Pg(I)^2 + b(I)*Pg(I) +c(I);
       Ci(I) = 2* a(I)* Pg(I)+ b(I);
       Ct    = Ct +   C(I);
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Impressão de resultados
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    format
    disp('************************************************************* ');
    disp('  ');
    saida2 = ['Pd=' num2str(Pd) 'MW'];
    disp(saida2);
    saida1 = ['Convergiu na iteração  ' num2str(k) '.'];
    disp(saida1);
    saida3 = ['Custo total=' num2str(Ct)   '$/h'];
    disp(saida3);
    disp(' ');
    disp('          Variáveis primais');
    disp('  ');
    disp('      Pg1       Pg2       Pg3');
    disp(Pg');
    disp(' ');
    disp('    spmin      spmax');
    disp([spmin      spmax]);
    disp('  ');
    disp( '           Variáveis Duais   ');
    disp(' ');
    disp('   Lambda     ');
    disp(      lambda);
    disp(' ');
    format short e;
    disp('    pipmin       pipmax  ');
    disp([pipmin  pipmax]);
    disp(' ');
    disp(' ');
    disp('      norma          mi');
    disp([normainf  mi]);
end

diary off
