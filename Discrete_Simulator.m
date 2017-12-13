function [ R, J ] = Discrete_Simulator( P, Pold )

global PARAMS

[ accum, d_accum_d_p ] = compute_accum(P);
[ trans, d_trans_d_p ] = compute_trans(P);
accum_old = compute_accum(Pold);

POT_DIFF = P(PARAMS.MESH(:, 2)) - P(PARAMS.MESH(:, 1)); % PINIT
K_HAR_AVG = 0.00112712 .* (PARAMS.Dx/PARAMS.Dy) .* 2 .* PARAMS.K(PARAMS.MESH(:, 1)).*PARAMS.K(PARAMS.MESH(:, 2))./(PARAMS.K(PARAMS.MESH(:, 1))+PARAMS.K(PARAMS.MESH(:, 2))); % Conversion Factor 
TRANS_ARITH_AVG = 0.5.*(trans(PARAMS.MESH(:, 2))+trans(PARAMS.MESH(:, 1)));

d_T_dL = 0.5 .* d_trans_d_p(PARAMS.MESH(:, 1)); % Why mult by 0.5
d_T_dR = 0.5 .* d_trans_d_p(PARAMS.MESH(:, 2));

F = K_HAR_AVG .* TRANS_ARITH_AVG .* POT_DIFF;
dF_dL = PARAMS.Dt .* K_HAR_AVG .* (d_T_dL .* POT_DIFF - TRANS_ARITH_AVG ); % Why negative transmissibility
dF_dR = PARAMS.Dt .* K_HAR_AVG .* (d_T_dR .* POT_DIFF + TRANS_ARITH_AVG );

R = ( 0.1781076 .* PARAMS.Dx .* PARAMS.Dy .* (accum - accum_old) ); % + ( PARAMS.Dt .* PARAMS.WELLS(:, 2) ) ; % STB?
R(PARAMS.WELLS(:, 1)) = R(PARAMS.WELLS(:, 1)) + PARAMS.Dt .* PARAMS.WELLS(:, 2);

% J = zeros(PARAMS.TOT, PARAMS.TOT);
% Jaccum = spdiags(d_accum_d_p, 0, PARAMS.TOT, PARAMS.TOT); % There is a mistake here
% J = J + Jaccum;

J = diag( (0.1781076 .* PARAMS.Dy .* PARAMS.Dx ) .* d_accum_d_p );

for i = 1:PARAMS.NUM_LIST % Minus vs Plus
    A = PARAMS.MESH(i, 1);
    B = PARAMS.MESH(i, 2);
    R(A) = R(A) - PARAMS.Dt .* F(i);
    R(B) = R(B) + PARAMS.Dt .* F(i);
    J(A, A) = J(A, A) - PARAMS.Dt .* dF_dR(i);
    J(A, B) = J(A, B) - PARAMS.Dt .* dF_dL(i);
    J(B, A) = J(B, A) - PARAMS.Dt .* dF_dR(i);
    J(B, B) = J(B, B) - PARAMS.Dt .* dF_dL(i); 
end
J = sparse(J);
% J(PARAMS.MESH(:, 1), PARAMS.MESH(:, 1)) = J(PARAMS.MESH(:, 1), PARAMS.MESH(:, 1)) - PARAMS.Dt .* dF_dL(PARAMS.MESH(:, 1));
% J(PARAMS.MESH(:, 1), PARAMS.MESH(:, 2)) = J(PARAMS.MESH(:, 1), PARAMS.MESH(:, 2)) - PARAMS.Dt .* dF_dR(PARAMS.MESH(:, 2));
% J(PARAMS.MESH(:, 2), PARAMS.MESH(:, 1)) = J(PARAMS.MESH(:, 2), PARAMS.MESH(:, 1)) - PARAMS.Dt .* dF_dL(PARAMS.MESH(:, 1));
% J(PARAMS.MESH(:, 2), PARAMS.MESH(:, 2)) = J(PARAMS.MESH(:, 2), PARAMS.MESH(:, 2)) - PARAMS.Dt .* dF_dR(PARAMS.MESH(:, 2));

% R(PARAMS.MESH(:, 1)) = R(PARAMS.MESH(:, 1) - PARAMS.Dt .* F(PARAMS.FACES(:));
% R(PARAMS.MESH(:, 2)) = R(PARAMS.MESH(:, 2) - PARAMS.Dt .* F(PARAMS.FACES(:));

end
