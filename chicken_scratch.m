% plotting sequences of points
%% constants
K = 20;
sig = 1;
beta = .5;

% visualizing: use hold for graphics, OR save all 
% configurations, plot at the end (probably better)
% optimize: remove all the loops in k
%% Initialization :Random positions, Random Velocities
dim = 2;
k = 10000; % number of birds in a flock
 % velocities of the birds
v_new = randn(dim,k);  % new velocities
pos_new = 1000*rand(dim,k); % positions of birds
 % positions of birds
deltat = 2e-1; % time step
eta = @(x,K,beta) K/(sig^2 + x)^beta;

%% Matrix A
A = zeros(k, k);

%% main loop: t =0 while (t < 1 ): 
% t = t + deltat
t=0;
while (t<1)
    t = t+deltat;
    pos = pos_new;
    for i=1:k
    for j =1:k
        A(i,j) = eta( (norm(pos(:,i)-pos(:,j)))^2 , K, beta);
    end
    end


%% Update velocities using equation (1)
v = v_new;
for i=1:k
    for j=1:k 
        v_new(:,i)= v_new(:,i) + A(i,j)*(v(:,j) - v(:,i));
    end
end

%% Update positions using first eqn in (4)
pos_new = pos +deltat*v;
end
quiver (pos_new(1,:), pos_new(2,:),  v_new(1,:), v_new(2,:));
% plotflock(pos);