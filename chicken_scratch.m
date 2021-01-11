% plotting sequences of points
%% constants
K = 200;
sig = 1;
beta = .2;

% - visualize better
% - optimize: remove all the loops in k
% - study flocks on surfaces: instead of putting birds in the plane,
% we would put them on a surface: torus, sphere, etc
%% Initialization :Random positions, Random Velocities
dim = 2;
k = 20; % number of birds in a flock
 % velocities of the birds
v_new = randn(dim,k);  % new velocities
pos_new = 1000*rand(dim,k); % positions of birds
 % positions of birds
deltat = 2e-1; % time step
eta = @(x,K,beta) K/(sig^2 + x)^beta;
T = 10; %T = time stopped

%% Matrix A
A = zeros(k, k);

%% main loop: t =0 while (t < 1 ): 
% t = t + deltat
t=0;
while (t<T)
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