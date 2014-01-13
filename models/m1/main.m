%% Initialization

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
data = load('data-train1.csv');
data_cv = load('data-cv1.csv');
X = data(:, 2:7);
y = data(:, 9);
Xval = data_cv(:, 2:7);
yval = data_cv(:, 9);
m = length(y);
mval = length(yval);

% Print out some data points
fprintf('First 10 examples from the dataset: \n');
fprintf(' x = %.0f, y = %.0f \n', [X(1:10,1) y(1:10,:)]');

%plotData(X(:,1), y);

fprintf('Solving with normal equations...\n');

% Add intercept term to X
X = [ones(m, 1) X];

% Calculate the parameters from the normal equation
theta = normalEqn(X, y);

% Plot the linear fit
%hold on; % keep previous plot visible
%plot(X(:,2), X*theta, '-')
%legend('Training data', 'Linear regression')
%hold off % don't overlay any more plots on this figure

% Display normal equation's result
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');

%prediction = [1,972000,35,8] * theta; 
%fprintf('Prediction = %f\n', prediction);

% ==== Learning Curve for Linear Regression =====

lambda = 0;
[error_train, error_val] = ...
    learningCurve(X, y, ...
                  [ones(size(Xval, 1), 1) Xval], yval, ...
                  lambda);

figure(2);				  
plot(3:m, error_train(3:m), 3:m, error_val(3:m));
title('Learning curve for linear regression')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
axis([1 25 0 2.5e+18])

fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
for i = 1:m
    fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
end

% print validation data predictions:
fprintf('Prediction in $mln:\n');
for i = 1:mval
	xv = Xval(i,:);
	xv = [1 xv];
	prediction = xv * theta; 
	% index: data_cv(i,1)
	fprintf('%.0f\n', prediction / 1000000);
end
