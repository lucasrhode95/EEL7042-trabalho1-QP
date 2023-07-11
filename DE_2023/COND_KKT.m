%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Rotina que calcula Condições de otimalidade
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
Spmin = diag(spmin);
Spmax = diag(spmax);

deltaLPg     = wc*(2*Q*Pg + b) - lambda*e - pipmin + pipmax;
deltaLspmin  = -mi*e + Spmin*pipmin;
deltaLspmax  = -mi*e + Spmax*pipmax;
deltaLlambda = - ( e'*Pg - Pd );
deltaLpipmin = -(Pg - Pgmin - spmin);
deltaLpipmax = -(-Pg + Pgmax - spmax);

deltaLprimal = [ deltaLPg; deltaLspmin; deltaLspmax ];
deltaLdual   = [deltaLlambda; deltaLpipmin; deltaLpipmax ];
deltaL       = [deltaLprimal; deltaLdual];
