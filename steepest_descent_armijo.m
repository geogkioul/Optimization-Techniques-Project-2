function [x, history] = steepest_descent_armijo(f, grad_f, x0, max_iter, tolerance)
    % Steepest descent method with Armijo rule for step size selection.
    %
    % Inputs:
    %   f          - Function handle of the objective function.
    %   grad_f     - Function handle for the gradient of f, given to avoid
    %   extra computational complexity
    %   x0         - Initial point (vector).
    %   max_iter   - Maximum number of iterations allowed
    %   tolerance  - Tolerance for stopping criteria (norm of gradient).
    %
    % Outputs:
    %   x          - Approximate solution.
    %   history    - History of points visited during optimization.
    
    % Armijo parameters
    beta = 0.5;     % Reduction factor (0 < beta < 1)
    alpha = 1e-4;   % Sufficient decrease parameter (0 < sigma < 1)
    
    % Initialization
    x = x0;                % Starting point
    history = x0';         % Store points for plotting
    
    % Start iteration
    for iter = 1:max_iter
        grad = grad_f(x);       % Compute the gradient
        grad_norm = norm(grad); % Norm of the gradient
        
        % Check stopping criteria
        if grad_norm < tolerance
            break;
        end
        
        % Determine descent direction (negative gradient)
        d = -grad;
        
        % Initialize step size for Armijo rule
        step = 1;
        
        % Armijo condition: f(x + step * p) <= f(x) + step * alpha * g' * p
        while f(x + step * d) > f(x) + step * alpha * (grad' * d)
            step = beta * step; % Reduce step
        end
        
        % Update the solution
        x = x + step * d;
        
        % Store the new point in history
        history = [history; x'];        
    end
end
