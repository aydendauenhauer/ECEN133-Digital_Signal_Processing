N = 360;                      % 30 years * 12 months
x = 1000 * ones(1, N);        % Monthly contributions
a = 1 + 0.05/12;              % Monthly interest growth
b = 1;                        % Feedforward coefficient
A = [1, -a];                  % Recursive (IIR) system: y[n] - a*y[n-1] = x[n]

y = filter(b, A, x);          % Compute output
fprintf("y[359] = %.2f\n", y(end));  % Value after 30 years

% Plot on a semi-log scale
n = 0:N-1;
semilogy(n, y)
xlabel('n (months)')
ylabel('Account Value (log scale)')
title('Growth of Retirement Account with Monthly Contributions')
grid on
%%
N = 30;                          % 30 years
x = zeros(1, N);
x(:) = 12000;                    % Annual contribution
a = 1.05;                        % Annual growth

b = 1;
A = [1, -a];

y = filter(b, A, x);
fprintf("y[29] = %.2f\n", y(end));  % Value after 30 years

% Optional: plot
n = 0:N-1;
semilogy(n, y)
xlabel('n (years)')
ylabel('Account Value (log scale)')
title('Growth of Retirement Account with Annual Contributions')
grid on
