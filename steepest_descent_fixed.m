function [x_min, history] = steepest_descent_fixed(grad_f, x0, max_iter, tolerance, gamma)
    % Steepest Descent Method with Fixed Step Size
    % 
    % Inputs:
    %   grad_f      - Gradient of the objective function, given directly to avoid
    %   extra computational complexity
    %   x0          - Initial point (column vector)
    %   max_iter    - Maximum number of iterations allowed
    %   tolerance   - Convergence tolerance (norm of the gradient)
    %   gamma       - Fixed step size (scalar)
    %
    % Outputs:
    %   x_min       - The optimized solution (column vector)
    %   history     - A matrix containing the iteration history of x

    % Initialize
    x = x0;  % Start from the initial guess
    history = x0';  % Store the initial guess in history (row vector format)

    for iter = 1:max_iter
        % Compute the gradient at the current point
        grad = grad_f(x);

        % Check convergence: if the norm of the gradient is smaller than the tolerance
        if norm(grad) < tolerance
            break;
        else
            % Steepest descent update
            x = x - gamma * grad;
            
            % Store the current point in history
            history = [history; x'];
        end
    end

    % Return the optimized solution and the history of all points
    x_min = x;
end
