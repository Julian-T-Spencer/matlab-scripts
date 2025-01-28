% eulerApproximation.m
% For approximating a first order ODE (of two variables) by Euler's method.
% julianSpencer
% 2025-Jan-25

clc; clear;

try
    % Specify ODE
    disp('Enter an ODE in the form dy/dx = f(x, y). (Do not use element-wise operators. Make sure to use * for every multiplication operation and / for every division.):');
    funcString = input('dy/dx = ', 's');
    modFuncString = strrep(funcString, '^', '.^');
    modFuncString = strrep(modFuncString, '*', '.*');
    modFuncString = strrep(modFuncString, '/', './');
    func = str2func(['@(x,y)', modFuncString]);

    testX = rand(1, 10);
    testY = rand(1, 10);
    try
        testFunc = func(testX, testY);
        clear testFunc;
    catch innerME
        error('The function you entered was not a valid function. Please enter a function of the form dy/dx = f(x, y). For example, dy/dx = "x + y".');
    end
    clear testX testY;

    %Specify step size & number of iterations
    x0 = input('Enter x0: ');
    y0 = input('Enter y0: ');
    h = input('Enter step-size: ');
    n = input('Enter number of iterations: ');
    
    if (~isnumeric(h))
            error('The step size you entered were not a numeric value. Please enter a numeric value.');
    end
    if (~isnumeric(n) || mod(n, 1) ~= 0)
            error('The number of iterations you entered was not a numeric integer. Please enter a numeric integer.');
    end
catch outerME
    disp('Terminating program due to invalid input...');
    error(['Reason: ', outerME.message]);
end

x = [x0];
y = [y0];

for i = 1:n
    slope = func(x(i), y(i));
    y(i+1) = y(i) + (h * slope);
    x(i+1) = x(i) + h;
end

disp(x);
disp(y);

% Plot the approximation
figure;
plot(x, y, '-b'); % Plot undefined as holes
axis tight;
xlabel('x');
ylabel('y');
t = "Approximation of solution to ";
t = strcat(t, funcString);
title(t);
hold off;