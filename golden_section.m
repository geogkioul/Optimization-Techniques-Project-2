function [a_vals, b_vals, f_evals] = golden_section(f, a, b, l)
    % GOLDEN_SECTION implements the Golden-Section method.
    % Inputs:
    %   f - function handle for the function f(x)
    %   a - initial left endpoint of the interval
    %   b - initial right endpoint of the interval
    %   l - minimum length of the interval for stopping
    
    % Outputs:
    %   a_vals  - the values of the left bound of interval during search
    %   b_vals  - the values of the right bound of interval during search
    %   f_evals - the number of times we evaluated the function f at a specific point

    % Initialize iteration counter and f_evals
    f_evals = 0;
    k = 1;

    % Initialize arrays to store values of a, b
    a_vals = a;
    b_vals = b;
   
    % Golden ratio factor
    gamma = 0.618;  % (-1 + sqrt(5)) / 2

    % Compute initial x1 and x2
    x1 = a + (1 - gamma) * (b - a);
    x2 = a + gamma * (b - a);

    % Evaluate function at x1 and x2
    f_x1 = f(x1);
    f_x2 = f(x2);
    f_evals = f_evals + 2; % Two evaluations of f so +2
    
    while (b - a >= l) % Loop until the interval length is less than l
        if f_x1 > f_x2 % Enter step 2
            % Update a and b for the next iteration
            a = x1; % a becomes x1, while b remains the same
            x1 = x2; % x1 becomes x2
            x2 = a + gamma * (b - a);  % Calculate new x2
            
            % Evaluate function at new x2
            f_x1 = f_x2; % no need to recalculate
            f_x2 = f(x2); % new value of f_x2
            f_evals = f_evals + 1; % One new calculation so +1
            
        else % Enter step 3
            % Update a and b for the next iteration
            b = x2;  % b becomes x2, while a remains the same
            x2 = x1;             % x2 becomes x1
            x1 = a + (1 - gamma) * (b - a);  % Calculate new x1
            
            % Evaluate function at new x2
            f_x2 = f_x1; % no need to recalculate
            f_x1 = f(x1); % new value of f_x1
            f_evals = f_evals + 1; % One new calculation so +1

        end
        % Update a_vals, b_vals with new values
        a_vals = [a_vals, a];
        b_vals = [b_vals, b];
        % Increment the iteration counter
        k = k + 1;
    end
end
