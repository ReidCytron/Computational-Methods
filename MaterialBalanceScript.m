% MaterialBalance1( 3000, 0.4, 0.5, 1000000, 10e-15, 10e-6, 10e-12, 10e-3, 1.2, 1.4, 0.0028, 1000, 100, 4e6, 50, 0.01 )

Pt1 = 3000;
Swt1 = 0.4;
Sot1 = 0.5;
V = 1e6;
cr = 10e-15;
co = 10e-6;
cw = 10e-12;
cg = 10e-3;
Bo = 1.2;
Bw = 1.4;
Bg = 0.0028;
Qo = 1000;
Qw = 100;
Qg = 1e6;
iterations = 50;
tolerance = 1;

MaterialBalance1( Pt1, Swt1, Sot1, V, cr, co, cw, cg, Bo, Bw, Bg, Qo, Qw, Qg, iterations, tolerance )

