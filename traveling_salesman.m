close all; clear all; clc;

% number of points (cities)
N = 20;

% [a,b] interval for x,y coordinates
a = 0;
b = 10;

% list of the points
points=zeros(N+1,2);
for i=1:N
    points(i,1) = floor((b-a).*rand(1) + a); % x coordinate
    points(i,2) = floor((b-a).*rand(1) + a); % y coordinate
end
N = N +1;
points(N,:) = points(1,:);
startLength = f(points)

%simulated annealing algorithm
max_iter = 1000;
eps = 0.1;
T0 = 1;
T = T0;
alpha = 0.1;
act = points;
better = 0; accept = 0; worse = 0;
for i=1:max_iter
    clf('reset');
    hold on; grid on;
    title('Simulated Annealing for Traveling Salesman Problem');
    plot(act(:,1), act(:,2), 'LineWidth', 2) % plot lines
    plot(act(:,1), act(:,2), 'ro', 'LineWidth', 3) % plot points
    pause(0.1)

    T = T - T0 * alpha^i;
    if (T <= eps) 
        break;
    end
    next = random_neighbor(act);
    DeltaE = f(next) - f(act);
    while DeltaE == 0 
        next = random_neighbor(act);
        DeltaE = f(next) - f(act);
    end
    if (DeltaE < 0)
        %display('jobbat talalt')
        act = next;
        better = better + 1;
    else
        if (exp(-DeltaE/T) >= rand(1))
            %display('elfogad')
            act = next;
            accept = accept + 1;
        else
            worse = worse + 1;
        end
    end
end
optLength = f(act)
nrBetterRoutes = better
nrWorseAcceptedRoutes = accept
nrWorseRoutes = worse

% *************************************************************************
function next = random_neighbor(act)
    N = length(act);
    % choose a,b from (2,N-1)
    a = round((N-3)*rand(1) + 2);
    b = round((N-3)*rand(1) + 2);
    if a > b
        temp = a; a = b; b = temp;
    end
    next = act;
    j=b;
    for i=a:b
        next(i,:) = act(j,:);
        j = j - 1;
    end
end

% *************************************************************************
function d = f(points)
    d = 0;
    N = length(points);
    for i=1:N-1
        d = d + sqrt((points(i,1) - points(i+1,1))^2 + (points(i,2) - points(i+1,2))^2);
    end
end
