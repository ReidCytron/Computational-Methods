global PARAMS

P = PARAMS.PINIT .* ones(PARAMS.TOT, 1);
time = 0;
Pold = P;
while (time < PARAMS.TIME_END)
    R = Discrete_Simulator( P, Pold );
    iteration = 1;
    while (norm(R, 2) > PARAMS.TOL) && (iteration < PARAMS.ITER)
        [ R, J ] = Discrete_Simulator( P, Pold );
        norm(R, 2);
        P = P - J\R;
        iteration = iteration + 1;
    end
    Pold = P;
    time = time + PARAMS.Dt;
end

Grid = zeros(PARAMS.Ny, PARAMS.Nx); % Flip for the loop
iteration = 1;
for i = 1:PARAMS.Ny
    for j = 1:PARAMS.Nx
        Grid(i, j) = P(i);
    end
end

% figure
% spy(sparse(J))
figure
imagesc(reshape(P, PARAMS.Nx, PARAMS.Ny))
figure
surf(reshape(P, PARAMS.Nx, PARAMS.Ny))
