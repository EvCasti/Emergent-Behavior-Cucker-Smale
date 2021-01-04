% plotting sequences of points
%hello world
%% constants
K = 20;
sig = 1;
beta = .5;
%% main loop: t =0 while (t < 1 ): 
% t = t + deltat
% put this on github in a public repository 
% visualizing: use hold for graphics, OR save all 
% configurations, plot at the end (probably better)
% optimize: remove all the loops in k
%% Initialization :Random positions, Random Velocities
dim = 2;
k = 1000; % number of birds in a flock
v = rand(dim,k); % velocities of the birds
v_new = zeros(dim,k); % new velocities
pos = rand(dim,k); % positions of birds
pos_new = zeros(dim,k); % positions of birds
deltat = 1e-2; % time step
eta = @(x,K,beta) K/(sig^2 + x)^beta;

%% Matrix A
A = zeros(k, k);
for i=1:k
    for j =1:k
        A(i,j) = eta( (norm(pos(:,i)-pos(:,j)))^2 , K, beta);
    end
end

%% Update velocities using equation (1)
for i=1:k
    v_new(:,i) = v(:,i);
    for j=1:k 
        v_new(:,i)= v_new(:,i) + A(i,j)*(v(:,j) - v(:,i));
    end
end

%% Update positions using first eqn in (4)
pos_new = pos +deltat*v;
quiver (pos(1,:), pos(2,:),  v(1,:), v(2,:));
% plotflock(pos);