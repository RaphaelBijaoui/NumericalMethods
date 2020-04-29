% Exercise 1, Group 7

%setting up methods, using a map of names to functions
method = containers.Map();
method("Heuns") = @(f, ts, xs, tf, h) RK(f, .5, .5, 1, 1, ts, xs, tf, h); 
method("Midpoint") = @(f, ts, xs, tf, h) RK(f, 0, 1, .5, .5, ts, xs, tf, h); 
method("Our Method") = @(f, ts, xs, tf, h) RK(f, 9/10, 1/10, 5, 5, ts, xs, tf, h);

for m = keys(method)
    % part 1: step input with amplitude 2.5 V
    figure;
    R = 1e3; C = 100e-9; % component values for 1.592kH cutoff
    ts = 0; tf = 7*R*C; % when know that an RC circuit will reach approximately steady state after 5 time periods 
    xs = 500e-9/C; % initally the charge is 500nC, we divide by C to get Vout
    plot(ts, xs, 'g+'); % plotting the initial conditions
    hold on;
    h = 2^(-20); % the step size needs to be samll, otherwise it becomes NaN
    vin = @(t) 2.5*heaviside(t); % the driving function of the ODE
    f = @(t, x) (vin(t) - x)/(R*C); % the gradient function in terms of t and x
    current_method = method(m{1})
    [t,x] = current_method(f, ts, xs, tf, h);
    plot(t, x, 'b*');
    hold off;
    title(['Application of 2nd Order RK Method - Heaviside using ' m{1}]);
    xlabel('Time / seconds');
    ylabel('Vout / Volts');
    legend('Initial Condition', 'Estimated Values');
    saveas(gcf, ['exercise1.1.' m{1} '.pdf']);


    % % part 2: impulse signal and decay
    % % part 2a: impulse input
    figure;
    tau = 100e-6;
    xs = 5; % initally the charge is 2.5V
    ts = 0; tf = R*C*7+300*tau; % when know that an RC circuit will reach approximately steady state after 5 time periods 
    plot(ts, xs, 'g+');
    hold on;
    h = 2^(-20); % the step size needs to be samll, otherwise it becomes NaN
    vin = @(t) 2.5*exp(-(t^2)/tau); % the driving function of the ODE
    decay = @(t, x) (vin(t) - x)/(R*C); % the gradient function in terms of t and x
    current_method = method(m{1})
    [t,x] = current_method(decay, ts, xs, tf, h);
    plot(t, x, 'b*');
    hold off;
    title(['Application of 2nd Order RK Method - Impulse Function using ' m{1}]);
    xlabel('Time / seconds');
    ylabel('Vout / Volts');
    legend('Initial Condition', 'Estimated Values');
    saveas(gcf, ['exercise1.2a.' m{1} '.pdf']);
    % the impulse response of a linear system can be used to find the frequency response of that system
    % this would tell us a lot about the nature of the filter
    figure;
    %fourier transform
    Y = fftshift(fft(x));
    % frequency spec
    N=length(t)
    dt = h
    Fs = 1/dt
    df = Fs/N
    f = -Fs/2:df:Fs/2-df
    % plot
    plot(f, abs(Y)/N, 'r', 'LineWidth', 4);
    title(['Application of 2nd Order RK Method - Frqeuency Response']);
    xlabel('Frequency / Hz');
    ylabel('Gain');
    saveas(gcf, ['exercise1.2a.' m{1} '.frequency.eps'], 'epsc');
    % plot decibels
    figure;
    semilogx(f, 20*log10(abs(Y)/N), 'r', 'LineWidth', 4);
    title(['Application of 2nd Order RK Method - Frqeuency Response dB']);
    xlabel('Frequency / Hz');
    ylabel('Gain (dB)');
    saveas(gcf, ['exercise1.2a.' m{1} '.frequency.dB.eps'], 'epsc');
 
    % % part 2b: decaying input
    figure;
    tau = 100e-6;
    xs = 5; % initally the charge is 2.5V
    ts = 0; tf = 7*tau+R*C*7; % when know that an RC circuit will reach approximately steady state after 5 time periods 
    plot(ts, xs, 'g+');
    hold on;
    h = 2^(-20); % the step size needs to be samll, otherwise it becomes NaN
    vin = @(t) 2.5*exp(-t/tau); % the driving function of the ODE
    f = @(t, x) (vin(t) - x)/(R*C); % the gradient function in terms of t and x
    
    current_method = method(m{1})
    [t,x] = current_method(f, ts, xs, tf, h);
    plot(t, x, 'b*');
    hold off;
    title(['Application of 2nd Order RK Method - Decaying Function using' m{1}]);
    xlabel('Time / seconds');
    ylabel('Vout / Volts');
    legend('Initial Condition', 'Estimated Values');
    saveas(gcf, ['exercise1.2b.' m{1} '.pdf']);

    for T = [10e-6, 100e-6, 500e-6, 1000e-6]
        % % part 3a: sine input
        figure;
        R = 1e3; C = 100e-9; % component values for 1.592kH cutoff
        ts = 0; tf = 7*R*C+3*T; % when know that an RC circuit will reach approximately steady state after 5 time periods 
        xs = 500e-9/C; % initally the charge is 500nC, we divide by C to get Vout
        plot(ts, xs, 'g+'); % plotting the initial conditions
        hold on;
        h = 2^(-20); % the step size needs to be samll, otherwise it becomes NaN
        f = 1/T; % calculating frequency
        vin = @(t) 5*sin(t*2*pi*f); % the driving function of the ODE
        f = @(t, x) (vin(t) - x)/(R*C); % the gradient function in terms of t and x
        current_method = method(m{1})
        [t,x] = current_method(f, ts, xs, tf, h);
        plot(t, x, 'b*');
        hold off;
        title(['Application of 2nd Order RK Method - Sinusoid with Timeperiod ' num2str(T*1e6) '\mus using ' m{1}] );
        xlabel('Time / seconds');
        ylabel('Vout / Volts');
        legend('Initial Condition', 'Estimated Values');
        saveas(gcf, ['exercise1.3a.' num2str(T*1e6) 'mus.' m{1} '.pdf']);

        % % part 3b: square input
        figure;
        R = 1e3; C = 100e-9; % component values for 1.592kH cutoff
        ts = 0; tf = 7*R*C+3*T; % when know that an RC circuit will reach approximately steady state after 5 time periods 
        xs = 500e-9/C; % initally the charge is 500nC, we divide by C to get Vout
        plot(ts, xs, 'g+'); % plotting the initial conditions
        hold on;
        h = 2^(-20); % the step size needs to be samll, otherwise it becomes NaN
        f = 1/T; % calculating frequency
        vin = @(t) 5*square(t*2*pi*f); % the driving function of the ODE
        f = @(t, x) (vin(t) - x)/(R*C); % the gradient function in terms of t and x
        current_method = method(m{1})
        [t,x] = current_method(f, ts, xs, tf, h);
        plot(t, x, 'b*');
        hold off;
        title(['Application of 2nd Order RK Method - Squarewave with Timeperiod ' num2str(T*1e6) '\mus using ' m{1}] );
        xlabel('Time / seconds');
        ylabel('Vout / Volts');
        legend('Initial Condition', 'Estimated Values');
        saveas(gcf, ['exercise1.3b.' num2str(T*1e6) 'mus.' m{1} '.pdf']);

        % % part 3c: sawtooth input
        figure;
        R = 1e3; C = 100e-9; % component values for 1.592kH cutoff
        ts = 0; tf = 7*R*C+3*T; % when know that an RC circuit will reach approximately steady state after 5 time periods 
        xs = 500e-9/C; % initally the charge is 500nC, we divide by C to get Vout
        plot(ts, xs, 'g+'); % plotting the initial conditions
        hold on;
        h = 2^(-20); % the step size needs to be samll, otherwise it becomes NaN
        f = 1/T; % calculating frequency
        vin = @(t) 5*sawtooth(t*2*pi*f); % the driving function of the ODE
        f = @(t, x) (vin(t) - x)/(R*C); % the gradient function in terms of t and x
        current_method = method(m{1})
        [t,x] = current_method(f, ts, xs, tf, h);
        plot(t, x, 'b*');
        hold off;
        title(['Application of 2nd Order RK Method - Sawtooth with Timeperiod ' num2str(T*1e6) '\mus using ' m{1}] );
        xlabel('Time / seconds');
        ylabel('Vout / Volts');
        legend('Initial Condition', 'Estimated Values');
        saveas(gcf, ['exercise1.3c.' num2str(T*1e6) 'mus.' m{1} '.pdf']);
    end
end
