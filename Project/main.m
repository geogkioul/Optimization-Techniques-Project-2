%% THIS SECTION SHOULD RUN FIRST BEFORE ANY OTHER FUNCTION OR SECTION
% Clear the workspace and command window
clear; clc;

% Define the objective function and its derivatives symbolically
syms x y;

% Objective function
f_sym=x^5*exp(-x^2-y^2);

% Gradient of objective
grad_sym=gradient(f_sym);

% Hessian of objective
hess_sym=hessian(f_sym);

% Convert the symbolic expressions to function handles to they can be
% passed to methods as arguments
f=matlabFunction(f_sym,'Vars',{[x;y]});
grad_f=matlabFunction(grad_sym,'Vars',{[x;y]});
hess_f=matlabFunction(hess_sym,'Vars',{[x;y]});

% Define tolerance parameter
tolerance=1e-4;
% Define a limit for maximum number of iterations
max_iter=10000;
% Define the fixed step size we will use 
fixed_step=0.05;

%% Task 1: Graph the function to get an intuition of it
grapher(f,5,5,100, 'surf'); % Surface Graph for x,y from -5 to 5 with 100 points in between
grapher(f,4,4,100, 'contour');


%% Tasks 2-4: Find the minimum of f using different methods for search
% We will run three different methods for 3 starting points
% We will examine what happens if we choose the step with different methods
starting_points=[0, 0; -1, 1; 1, -1];
step_modes=["fixed", "linesearch", "armijo"];
graph_type='contour';
% The code for each task is the same except for the titles and the function
% calls

%% Task 2: Steepest Descent method
for j = 1:3 % For every different mode of step selection
    for i = 1:size(starting_points, 1) % And every different starting point
        x=starting_points(i, 1);
        y=starting_points(i, 2);
        x0=[x;y]; % Make the starting point a column vector as needed for the function
    
        [xmin, history] = steepest_descent(f, grad_f, x0, max_iter, tolerance, step_modes(j), fixed_step);
        grapher(f,3,3,200,graph_type);
        hold on;
        legend show;
        title('Trajectory of optimization point to convergence during Steepest Descent');
        subtitle('Step size selection mode: ' + sprintf(step_modes(j)) + newline + 'Number of iterations until termination: ' + size(history,1) + newline + 'Point of convergence: ('+ xmin(1) + ', ' + xmin(2) + ')' + newline + 'Value of f at point of convergence: ' + f(xmin));
        % Extract the coordinates of the points during descent
        history_x = history(:, 1);
        history_y = history(:, 2);
        history_z = arrayfun(@(i) f([history_x(i); history_y(i)]), 1:size(history,1));
    
        % History_z is row vector, transpose it to make it a column vector
        history_z = history_z';
    
        % Plot the descent trajectory
        plot3(history_x, history_y, history_z, '-x', 'LineWidth',1,'MarkerSize',8,'Color','r', 'DisplayName','Trajectory of optimization');
    
        % Mark especially the final point of convergence
        plot3(history_x(end),history_y(end),history_z(end), 'Marker', 'diamond', 'MarkerSize', 10, 'LineWidth', 2, 'Color','b','DisplayName','Point of convergence');
    end
end

%% Task 3: Newton's method
for j = 1:3 % For every different mode of step selection
    for i = 1:size(starting_points, 1) % And every different starting point
        x=starting_points(i, 1);
        y=starting_points(i, 2);
        x0=[x;y]; % Make the starting point a column vector as needed for the function
    
        [xmin, history] = newton_method(f, grad_f, hess_f, x0, max_iter, tolerance, step_modes(j), fixed_step);
        grapher(f,3,3,200,graph_type);
        hold on;
        legend show;
        title("Trajectory of optimization point to convergence during Newton's method");
        subtitle('Step size selection mode: ' + sprintf(step_modes(j)) + newline + 'Number of iterations until termination: ' + size(history,1) + newline + 'Point of convergence: ('+ xmin(1) + ', ' + xmin(2) + ')' + newline + 'Value of f at point of convergence: ' + f(xmin));
        % Extract the coordinates of the points during descent
        history_x = history(:, 1);
        history_y = history(:, 2);
        history_z = arrayfun(@(i) f([history_x(i); history_y(i)]), 1:size(history,1));
    
        % History_z is row vector, transpose it to make it a column vector
        history_z = history_z';
    
        % Plot the descent trajectory
        plot3(history_x, history_y, history_z, '-x', 'LineWidth',1,'MarkerSize',8,'Color','r', 'DisplayName','Trajectory of optimization');
    
        % Mark especially the final point of convergence
        plot3(history_x(end),history_y(end),history_z(end), 'Marker', 'diamond', 'MarkerSize', 10, 'LineWidth', 2, 'Color','b','DisplayName','Point of convergence');
    end
end

%% Task 4: Levenberg-Marquardt method
for j = 1:3 % For every different mode of step selection
    for i = 1:size(starting_points, 1) % And every different starting point
        x=starting_points(i, 1);
        y=starting_points(i, 2);
        x0=[x;y]; % Make the starting point a column vector as needed for the function
    
        [xmin, history] = leven_marq_method(f, grad_f, hess_f, x0, max_iter, tolerance, step_modes(j), fixed_step);
        grapher(f,3,3,200,graph_type);
        hold on;
        legend show;
        title('Trajectory of optimization point to convergence during Levenberg-Marquardt method');
        subtitle('Step size selection mode: ' + sprintf(step_modes(j)) + newline + 'Number of iterations until termination: ' + size(history,1) + newline + 'Point of convergence: ('+ xmin(1) + ', ' + xmin(2) + ')' + newline + 'Value of f at point of convergence: ' + f(xmin));
        % Extract the coordinates of the points during descent
        history_x = history(:, 1);
        history_y = history(:, 2);
        history_z = arrayfun(@(i) f([history_x(i); history_y(i)]), 1:size(history,1));
    
        % History_z is row vector, transpose it to make it a column vector
        history_z = history_z';
    
        % Plot the descent trajectory
        plot3(history_x, history_y, history_z, '-x', 'LineWidth',1,'MarkerSize',8,'Color','r', 'DisplayName','Trajectory of optimization');
    
        % Mark especially the final point of convergence
        plot3(history_x(end),history_y(end),history_z(end), 'Marker', 'diamond', 'MarkerSize', 10, 'LineWidth', 2, 'Color','b','DisplayName','Point of convergence');
    end
end