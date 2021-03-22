using Plots;
using LinearAlgebra;
# constants
K = 200;
sig = 1;
beta = .3;

# Initialization: Random positions, Random Velocities
dim = 2;
k = 5;                               # number of birds in a flock
L = 100;                               # size of the starting box
v_new = randn(k, dim);                 # initial velocities
pos_new = L*rand(k, dim);              # initial positions of birds
deltat = 1e-2;                        # time step
eta = (x,K,beta) -> K/(sig^2 + x)^beta;
T = 2;                               # stopping time

# Matrix A
A = zeros(k, k);

# main loop
t=0;
# hold on;
while (t<T)
    global t = t+deltat;
    pos = pos_new;
    for i=1:k
        for j =1:k
            A[i,j] = eta( (norm(pos[i,:]-pos[j,:]))^2 , K, beta);
        end
    end

    # Update velocities using equation (1)
    for i=1:k
        for j=1:k 
            v_new[i,:]= v_new[i,:] + A[i,j]*(v_new[j,:] - v_new[i,:]);
        end
    end

    # Update positions using first eqn in (4)
    global pos_new = pos +deltat*v_new;
end

scatter(pos_new[:,1], pos_new[:,2]);
# quiver(pos_new[:,1], pos_new[:,2], quiver=(v_new[:,1], v_new[:,2]));

# show(stdout, "text/plain", pos_new)
# println("\n");
