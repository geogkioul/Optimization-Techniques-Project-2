function [x, history] = steepest_descent_with_line_search(f, grad_f, x0, tolerance, max_iter, golden_search)
    % Steepest Descent Method with Step Size defined by Golden Search
    % Method in the direction of gradient
    %
    % Inputs:
    % grad_f        - Function handle for the gradient of f, given directly
    % to avoid extra computational complexity
    % x0            - Initial point (vector)
    % tolerance     - Convergence tolerance (norm of the gradient)
    % max_iter      - Maximum number of iterations allowed
    %
    % Outputs:
    % x_min         - The optimized solution (column vector)
    % history       - A matrix containing the iteration history of x

    % Initialize
    x = x0;                     % Current point
    history = x';                % Store history of x values
    
    for iter = 1:max_iter
        % Compute the gradient
        grad = grad_f(x);
        
        % Check convergence
        if norm(grad) < tolerance
            break;
        end
        
        % Define the line search objective function along the search direction
        p = -grad; % Descent direction (negative gradient)
        phi = @(gamma) f(x + gamma * p); % Line search objective
        
        % Perform line search using golden section method
        gamma = golden_search(phi, 0, 1, 1e-4); % Adjust search bounds as needed
        
        % Update x
        x = x + gamma * p;
        
        % Store the current point in history
        history = [history; x'];
    end
end
