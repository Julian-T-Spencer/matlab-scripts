% electricFieldFalloff.m
% For visualizing the falloff of an electric field of a test charge that is positioned
% perpendicular to the center of a row of positive charges.
% julianSpencer
% 2025-Jan-25

clc; clear;

% x = input("Enter spacing of positive charges (meters): ");
% n = input("Enter number of positive charges (must be odd integer): ");
x = 0.5;
n = 11;

if (~isnumeric(x) || ~isnumeric(n))
    error("Input must be numeric!");
end
if (mod(n, 2) ~= 1)
    error("n must be an odd integer!");
end

d = 0.2:0.001:1.2;
bounds = (n-1)/2;

% Electric Field Calculation
E = 0;
for i = -bounds:bounds
    E = E + (d./((((x^2)*(i^2))+(d.^2)).^(3/2)));
end
E = E * (1 * 10^-9) * (8.99 * 10^9);

figure;
plot(d, C, '-b');
hold on;
plot(d, E, '-r');
xlabel('Distance of Test Charge');
ylabel('Strength of Electric Field (J-Hat Direction)');
title('Falloff of Electric Field');