% % part 3a: sine input

% base comparison

%setting up methods
method = containers.Map();
method("Heuns") = @(f, ts, xs, tf, h) RK(f, .5, .5, 1, 1, ts, xs, tf, h); 
method("Midpoint") = @(f, ts, xs, tf, h) RK(f, 0, 1, .5, .5, ts, xs, tf, h); 
method("Our Method") = @(f, ts, xs, tf, h) RK(f, 9/10, 1/10, 5, 5, ts, xs, tf, h); 

T = 100e-6;
R = 1e3; C = 100e-9; % component values for 1.592kH cutoff
ts = 0; tf = 7*R*C+3*T; % when know that an RC circuit will reach approximately steady state after 5 time periods 
xs = 500e-9/C; % initally the charge is 500nC, we divide by C to get Vout
h = 2^(-20); % the step size needs to be samll, otherwise it becomes NaN
f = 1/T; % calculating frequency


% Solving the ode
syms y(t);
ode = y(t) + diff(y,t)*R*C == 5*cos(f*2*pi*t);
cond = y(0) == 5; % initially vout is 5v
exact_solution = dsolve(ode,cond);
exact = matlabFunction(exact_solution);


vin = @(t) 5*cos(t*2*pi*f); % the driving function of the ODE
f = @(t, x) (vin(t) - x)/(R*C); % the gradient function in terms of t and x

for m = keys(method)
    figure;
    
    h = 2^(-20); % the step size needs to be samll, otherwise it becomes NaN
    plot(ts, xs, 'g+'); % plotting the initial conditions
    hold on;
    current_method = method(m{1});
    [t,x] = current_method(f, ts, xs, tf, h);
    plot(t, x, 'b*');

    xx = arrayfun(exact, t)
    plot(t, xx, 'r-');


    hold off;
    title(['Application of ' m{1} ' Method - Comparing Numerical and Exact'] );
    xlabel('Time / seconds');
    ylabel('Vout / Volts');
    legend('Initial Condition', 'Estimated Values', 'Exact Values');
    saveas(gcf, ['exercise2.' m{1} '.exact.eps'], 'epsc');


    figure;
    abs_error = abs(xx - x);
    plot(t, abs_error, 'r');
    title(['Application of ' m{1} ' Method - Absolute Local Error'] );
    xlabel('Time / seconds');
    ylabel('Absolute Error / Volts');
    saveas(gcf, ['exercise2.' m{1} '.local.eps'], 'epsc');

    % doing global error
    figure;
    for p = 15:30
        h = 2^(-p);
        current_method = method(m{1});
        [t,x] = current_method(f, ts, xs, tf, h);
        xx = arrayfun(exact, t)
        abs_error = abs(xx-x);
        ma = max(abs_error);
        plot(log(h),log( ma), 'r*');
        hold on;
    end
    hold off;
    title(['Application of ' m{1} ' Method - Absolute Global Error'] );
    xlabel('Step Size h / seconds');
    ylabel('Absolute Error / Volts');
    saveas(gcf, ['exercise2.' m{1} '.global.eps'], 'epsc');
end


