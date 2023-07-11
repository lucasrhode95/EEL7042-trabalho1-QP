%  Forma W
%
Zzero1  = zeros(ng,2*ng);

Vetorpi = [pipmin; pipmax];
PI      = diag(Vetorpi);
vetorS  = [spmin; spmax];
S       = diag(vetorS);


W=[
    2*wc*Q zeros(ng,2*ng) -e -diag(e) +diag(e);
    zeros(2*ng,ng) PI  zeros(2*ng,1) S;
    -e' zeros(1, 4*ng+1);
    -diag(e)  diag(e) zeros(ng,3*ng+1);
    diag(e) zeros(ng,ng) diag(e) zeros(ng,2*ng+1)
];
%
