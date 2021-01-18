%% TODO list
% - visualize better
% - optimize: remove all the loops in k (? bsxfun)
% - study flocks on surfaces: instead of putting birds in the plane,
% we would put them on a surface: torus, sphere, etc

%% constants
K = 200;
sig = 1;
beta = .3;

%% Initialization: Random positions, Random Velocities
dim = 2;
k = 80;                               % number of birds in a flock
L = 100;                               % size of the starting box
v_new = randn(dim,k);                 % initial velocities
pos_new = L*rand(dim,k);              % initial positions of birds
deltat = 1e-2;                        % time step
eta = @(x,K,beta) K/(sig^2 + x)^beta;
T = 10;                               % stopping time

%% Matrix A
A = zeros(k, k);

%% main loop
t=0;
% hold on;
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
% if (t > 0.9 * T)
%     quiver (pos(1,:), pos(2,:),  deltat*v(1,:), deltat*v(2,:) );
% end

end
% hold off;

%% Subtract the mean from positions
% pos_new = pos_new - mean(pos_new,2);

quiver (pos(1,:), pos(2,:),  deltat*v(1,:), deltat*v(2,:));
% quiver (zeros(size(pos_new(1,:))), zeros(size(pos_new(2,:))),  v_new(1,:), v_new(2,:),0);

