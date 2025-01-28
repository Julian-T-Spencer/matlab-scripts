% Direction Field Visualizer
% For ODE's of form dy/dx = f(x, y)
% Julian Spencer w/ help of ChatGPT 4o
% 2025-Jan-24

clear; clc;

% Input
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
        testSlope = func(testX, testY);
        clear testSlope;
    catch innerME
        error('The function you entered was not a valid function. Please enter a function of the form dy/dx = f(x, y). For example, dy/dx = "x + y".');
    end
    clear testX testY;

    %Specify bounds & spacing
    disp('Enter intended bounds & spacing:');
    xString = input('X bounds & spacing (lower:spacing:upper): ', 's');
    yString = input('Y bounds & spacing (lower:spacing:upper): ', 's');

    x = eval(xString);
    y = eval(yString);
    
    if ~isnumeric(x)
            error('The x bounds you entered were not a valid numeric range. Please enter it in the form "lowerBound:spacing:upperBound". For example, "-2:0.5:1".');
    end
    if ~isnumeric(y)
            error('The y bounds you entered were not a valid numeric range. Please enter it in the form "lowerBound:spacing:upperBound". For example, "-2:0.5:1".');
    end
catch outerME
    disp('Terminating program due to invalid input...');
    error(['Reason: ', outerME.message]);
end

% Create grid
[X, Y] = meshgrid(x, y);

% Populate slopes
Z = func(X, Y);

% Account for undefined results
undefinedMask = isnan(Z) | isinf(Z);
undefinedX = X(undefinedMask);
undefinedY = Y(undefinedMask);
Z_clean = Z(~undefinedMask);
X_clean = X(~undefinedMask);
Y_clean = Y(~undefinedMask);
undefinedCoordinatesX = undefinedX;
undefinedCoordinatesY = undefinedY;

% Recompute normalized vectors for valid points
L = sqrt(1 + Z_clean.^2);
u = 0.5 ./ L;
v = 0.5 * Z_clean ./ L;
X_start = X_clean - u;
Y_start = Y_clean - v;

% Plot the directional field
figure;
quiver(X_start, Y_start, 2*u, 2*v, 'k');
hold on;
plot(undefinedX, undefinedY, 'ko'); % Plot undefined as holes
axis tight;
xlabel('x');
ylabel('y');
t = "Directional field of ";
t = strcat(t, funcString);
title(t);
hold off;