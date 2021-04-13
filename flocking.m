function flocking(k)
% INPUTS:
% k - number of birds in a flock

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
k = 200;
L = 100;                               % size of the starting box

v_new = L*randn(dim,k);                 % initial velocities
pos_new = L*randn(dim,k);              % initial positions of birds

deltat = 1e-2;                        % time step
T = 2;                               % stopping time

eta = @(x,K,beta) K/(sig^2 + x)^beta;

vid = VideoWriter('flocking.avi');
vid.FrameRate = 5;              % frames per second
vid.Quality = 90;
open(vid);

%% Matrix A
A = zeros(k, k);

%% main loop
t=0;
% hold on;
while (t<T)
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
    
    if (t<0.2)
        quiver (pos_new(1,:), pos_new(2,:),  deltat*v_new(1,:), deltat*v_new(2,:),0,...
            'Marker', 'o', 'MarkerSize', 3, 'MarkerFaceColor', 'black');
    else
        quiver (pos_new(1,:), pos_new(2,:),  v_new(1,:), v_new(2,:),...
            'Marker', 'o', 'MarkerSize', 3, 'MarkerFaceColor', 'black');
    end
    axis equal;
    % xlim([xmin xmax]);
    % ylim([ymin ymax]);
    drawnow;    
    frame = getframe(gcf);
    writeVideo(vid,frame);
    
    
    
end

close(vid);
