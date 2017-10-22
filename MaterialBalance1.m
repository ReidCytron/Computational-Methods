function [ X ] = MaterialBalance1( Pt1, Swt1, Sot1, V, cr, co, cw, cg, Bo, Bw, Bg, Qo, Qw, Qg, iterations, tolerance )
% MaterialBalance1( 3000, 0.4, 0.5, 1000000, 10e-15, 10e-6, 10e-12, 10e-3, 1.2, 1, 1.4, 1000, 100, 4e6, 50,0.01 )

syms Pt2 Swt2 Sot2

Qot2 = (0.25*exp(cr*(Pt2-3000))*V*Sot2)/(Bo/(1+co*(Pt2-3000)+0.5*co*((Pt2-3000)^2)));
Qot1 = (0.25*exp(cr*(Pt1-3000))*V*Sot1)/(Bo/(1+co*(Pt1-3000)+0.5*co*((Pt1-3000)^2)));

Qwt2 = (0.25*exp(cr*(Pt2-3000))*V*Swt2)/(Bw/(1+cw*(Pt2-3000)+0.5*cw*((Pt2-3000)^2)));
Qwt1 = (0.25*exp(cr*(Pt1-3000))*V*Swt1)/(Bw/(1+cw*(Pt1-3000)+0.5*cw*((Pt1-3000)^2)));

Qgt2 = (0.25*exp(cr*(Pt2-3000))*V*(1-Sot2-Swt2))/(Bg/(1+cg*(Pt2-3000)+0.5*cg*((Pt2-3000)^2)));
Qgt1 = (0.25*exp(cr*(Pt1-3000))*V*(1-Sot2-Swt2))/(Bg/(1+cg*(Pt1-3000)+0.5*cg*((Pt1-3000)^2)));

fo = Qot2  - Qot1 - Qo;
fw = Qwt2 - Qwt1 - Qw;
fg = Qgt2 - Qgt1 - Qg;
f = [fo; fw; fg];

y = jacobian([fo, fw, fg], [Pt2; Swt2; Sot2]);

X = [1; 1; 1];

for i = 1:iterations

    xxx = y;
    zzz = f;

    xxx = subs(xxx, Pt2, X(1, 1));
    xxx = subs(xxx, Swt2, X(2, 1));
    xxx = subs(xxx, Sot2, X(3, 1));
    xxx = double(xxx);

    zzz = subs(zzz, Pt2, X(1, 1));
    zzz = subs(zzz, Swt2, X(2, 1));
    zzz = subs(zzz, Sot2, X(3, 1));
    zzz = double(zzz);

    X_Last = X;

    X = X - inv(xxx) * zzz;

     error(i,1) = norm((X - X_Last));
     if (error(i,1) < tolerance)
         break;

     end
    i = i + 1;

end

plot(error)
title('Case 5')
xlabel('Iterations')
ylabel('Convergence')

