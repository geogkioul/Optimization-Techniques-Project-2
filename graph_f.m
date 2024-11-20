function graph_f(f, x_vals, y_vals, resolution)
% A script that will take as input a 3d function and graph it
% 
% Inputs:
% f             - Function handle for the function to graph
% x_vals        - The x values for which the function will be graphed
% (-x_vals, x_vals)
% y_vals        - The y values for which the function will be graphed
% (-y_vals, y_vals)
% resolution    - The number of points the in each dimension

% Create a grid of x, y values
x = linspace(-x_vals, x_vals, resolution);
y = linspace(-y_vals, y_vals, resolution);
[X, Y] = meshgrid(x, y);

% Evaluate the function at the grid points
Z = arrayfun(@(x, y) f([x; y]), X, Y);

% Plot the function

% Surface plot
figure; % Create a figure
surf(X, Y, Z);
xlabel('x');
ylabel('y');
zlabel('f(x, y)');
title('3D Surface Plot of f');

% Mesh plot
figure; % Create a figure
mesh(X, Y, Z);
xlabel('x');
ylabel('y');
zlabel('f(x, y)');
title('3D Mesh Plot of f');

% Contour plot
figure; % Create a figure
contour(X, Y, Z);
xlabel('x');
ylabel('y');
zlabel('f(x, y)');
title('2D Contour Plot of f');


