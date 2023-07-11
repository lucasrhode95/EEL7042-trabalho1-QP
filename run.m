%% VARIÁVEIS DUMMY
npg = size(Pgmax)(1);
xPg = ones(npg, 1);

%% CHUTE INICIAL
x0 = (Pgmax + Pgmin)/2;

H = 2*Q;
q = b;

A  = Iaux;
bb = Pd - Pgsolar;

A_in = [
    eye(npg, npg);
    Mat_hor;
];

A_ub = [
    Pgmax;
    Cap;
];
A_lb = [
    Pgmin;
    0*Cap;
];


lb = -500*xPg;
ub = 500*xPg;

[x, obj, info, lambda] = qp(x0, H, q, A, bb, lb, ub, A_lb, A_in, A_ub);

switch (info.info)
case 1
    disp("WARNING: The problem is not convex. Local solution found.");
case 2
    disp("The problem is not convex and unbounded.");
    return;
case 3
    disp("Maximum number of iterations reached.")
    return;
case 6
    disp("The problem is infeasible.");
    return;
end

[pTermica pBateria] = desintercalar(x);

printVetor("TERMICA=", pTermica);
printVetor("BATERIA=", pBateria);
