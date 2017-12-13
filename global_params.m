global PARAMS

PARAMS.Nx = 25;
PARAMS.Ny = 25;
PARAMS.Dx = 100;
PARAMS.Dy = 100;
PARAMS.TOT = PARAMS.Nx * PARAMS.Ny;
PARAMS.FACES = ones(PARAMS.TOT, 1);
for i = 1:PARAMS.TOT
    PARAMS.FACES(i, 1) = i;
end
PARAMS.NUM_LIST = PARAMS.Nx * (PARAMS.Ny - 1) + (PARAMS.Nx-1) * PARAMS.Ny;

PARAMS.Cx = 10.0;
PARAMS.K = 40 .* ones(PARAMS.TOT, 1);

PARAMS.PORO_REF = 0.3 .* ones(PARAMS.TOT, 1);
PARAMS.PINIT = 3000.0;
PARAMS.Cr = 1e-5;
PARAMS.Cf = 1e-4;
PARAMS.FVF_REF = 1.0;
PARAMS.VIS = 2.5;
PARAMS.POLD = 3000;

PARAMS.TIME_END = 50;
PARAMS.Dt = 0.1;
PARAMS.ITER = 5;
PARAMS.TOL = 1e-2;
PARAMS.WELLS = [1, 20; PARAMS.TOT, 20; PARAMS.Nx, 20; PARAMS.TOT-(PARAMS.Nx-1), 20; (PARAMS.TOT-1)/2, -50 ]; % Makes it a vector
PARAMS.WELLS_LIST = size(PARAMS.WELLS, 1); % Counts wells

PARAMS.WELL_CHANGE = zeros(PARAMS.TOT, 1);
if PARAMS.WELLS_LIST > 0
    PARAMS.WELL_CHANGE(PARAMS.WELLS(:, 1)) = PARAMS.WELLS(:, 2);
end


% Connection List
clear CONLIST
clear CONNLIST
y = PARAMS.Ny;
x = PARAMS.Nx;
i = 1;
while y >= 1
    while x >= 1
        CONLIST(y,x)=i;
        x=x-1;
        i=i+1;
    end
    x=PARAMS.Nx;
    y=y-1;
end
CONLIST = fliplr(CONLIST);
CONNLIST = zeros((PARAMS.Nx-1)*PARAMS.Ny+PARAMS.Nx*(PARAMS.Ny-1), 2);
VERT = zeros((PARAMS.Nx-1)*PARAMS.Ny, 2);
HORIZ = zeros((PARAMS.Ny-1)*PARAMS.Nx, 2);
L = 1;
x = PARAMS.Nx;
y = PARAMS.Ny;
while y >= 1
    for i = 1:x-1
        HORIZ(L, 1) = CONLIST(y, i);
        HORIZ(L, 2) = CONLIST(y, i) + 1;
        CONNLIST(L, 1) = CONLIST(y, i);
        CONNLIST(L, 2) = CONLIST(y, i) + 1;
        L = L + 1;
    end
    y = y - 1;
    x = PARAMS.Nx;
end
x = PARAMS.Nx;
y = PARAMS.Ny;
A = 1;
while y >= 2
    for i = 1:x
        VERT(A, 1) = CONLIST(y, i);
        VERT(A, 2) = CONLIST(y, i) + PARAMS.Ny;
        CONNLIST(L, 1) = CONLIST(y, i);
        CONNLIST(L, 2) = CONLIST(y, i) + PARAMS.Nx;
        L = L + 1;
        A = A + 1;
    end
    y = y - 1;
    x = PARAMS.Nx;
end
PARAMS.HORIZ = HORIZ;
PARAMS.VERT = VERT;
PARAMS.MESH = CONNLIST;


%Simulator
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
