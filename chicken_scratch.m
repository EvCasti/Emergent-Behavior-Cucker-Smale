%% TODO list
% - visualize better
% - optimize: remove all the loops in k (? bsxfun)
% - study flocks on surfaces: instead of putting birds in the plane,
% we would put them on a surface: torus, sphere, etc

%% constants
K = 1;
sig = .1;
beta = .3;

%% Initialization: Random positions, Random Velocities
dim = 2;
k = 20;                               % number of birds in a flock
L = 100;                               % size of the starting box
v_new = randn(dim,k);                 % initial velocities
pos_new = L*rand(dim,k);              % initial positions of birds
deltat = 1e-2;                        % time step
eta = @(x,K,beta) K/(sig^2 + x)^beta;
T = 3;                               % stopping time
variances = zeros(T/deltat+1,1);

vid = VideoWriter('flocking.avi');
vid.FrameRate = 5;              % frames per second
vid.Quality = 90;
open(vid);

%% Matrix A
A = zeros(k, k);

%% main loop
t=0;
iter = 0;
% hold on;
while (t<T)
    iter = iter + 1;
    t = t+deltat;
    for i=1:k
        for j =1:k
            A(i,j) = eta( (norm(pos_new(:,i)-pos_new(:,j)))^2 , K, beta);
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
pos_new = pos_new +deltat*v_new;
variances(iter) = norm(var(pos_new'));

hold on;
plot(pos_new(1,:), pos_new(2,:), '.b', 'MarkerSize', 12);
quiver (pos_new(1,:), pos_new(2,:),  v_new(1,:), v_new(2,:));

axis equal;
xlim([-10 200]);
ylim([-10 200]);
hold off;

frame = getframe(gcf);
writeVideo(vid,frame);



end

close(vid);

% quiver (zeros(size(pos_new(1,:))), zeros(size(pos_new(2,:))),  v_new(1,:), v_new(2,:),0);

