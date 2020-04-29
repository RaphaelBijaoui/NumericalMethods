% Exercise 3, Group 7
R = 250; C = 3.5e-6; L = 500e-3;
h = 2^-15;
ts = 0; tf = 20*R*C/L;
ys = 500e-9; zs = 0; % initial current is zero
vin = @(t) 5*heaviside(t);
dy = @(t, y, z) z; 
dz = @(t, y, z) (vin(t) - R*z - (1/C)*y)/L;
[t, y, z] = RK4(dy, dz, ts, ys, zs, tf, h);
plot(t, z*R, '*');
title('Application of 4th Order RK Method to 2nd Order ODE (RLC Circuit)' );
xlabel('Time / seconds');
ylabel('Vout / Volts');
saveas(gcf, 'exercise3.1.pdf');

for f = [109, 5, 500]
    % sinusoid
    figure;
    R = 250; C = 3.5e-6; L = 500e-3;
    h = 2^-15
    ts = 0; tf = 12*R*C/L+(1/f);
    ys = 500e-9; zs = 0; % initial current is zero
    vin = @(t) 5*sin(t*2*pi*f);
    dy = @(t, y, z) z; 
    dz = @(t, y, z) (vin(t) - R*z - (1/C)*y)/L;
    [t, y, z] = RK4(dy, dz, ts, ys, zs, tf, h);
    plot(t, z*R, '*');
    title(['Application of 4nd Order RK Method - Sinusoid with Frequency ' num2str(f) 'Hz']);
    xlabel('Time / seconds');
    ylabel('Vout / Volts');
    saveas(gcf, ['exercise3.sinusoid.' num2str(f) 'Hz.pdf']);
    
    %square wave etc.
    figure;
    R = 250; C = 3.5e-6; L = 500e-3;
    h = 2^-15
    ts = 0; tf = 12*R*C/L+(1/f);
    ys = 500e-9; zs = 0; % initial current is zero
    vin = @(t) 5*square(2*pi*f*t);
    dy = @(t, y, z) z; 
    dz = @(t, y, z) (vin(t) - R*z - (1/C)*y)/L;
    [t, y, z] = RK4(dy, dz, ts, ys, zs, tf, h);
    plot(t, z*R, '*');
    title(['Application of 4nd Order RK Method - Square with Frequency ' num2str(f) 'Hz']);
    xlabel('Time / seconds');
    ylabel('Vout / Volts');
    saveas(gcf, ['exercise3.square.' num2str(f) 'Hz.pdf']);         
end
    
%Impulse input
figure;
R = 250; C = 3.5e-6; L = 500e-3;
ts = 0; tf = 20*R*C/L;
h = 2^-15;
ys = 500e-9; zs = 0; % initial current is zero

tau = 3e-6;
vin = @(t) 5*exp(-t^2/tau); % the impulse function 

dy = @(t, y, z) z; 
dz = @(t, y, z) (vin(t) - R*z - (1/C)*y)/L;
[t, y, z] = RK4(dy, dz, ts, ys, zs, tf, h);
plot(t, z*R, '*');
title(['Application of 4nd Order RK Method - Impulse']);
xlabel('Time / seconds');
ylabel('Vout / Volts');
saveas(gcf, ['exercise3.impulsedecay.pdf']); 

% the impulse response of a linear system can be used to find the frequency response of that system
% this would tell us a lot about the nature of the filter
figure;
%fourier transform
Y = fftshift(fft(z*R));
% frequency spec
N=length(t)
dt = h
Fs = 1/dt
df = Fs/N
f = -Fs/2:df:Fs/2-df
% plot
plot(f, abs(Y)/N, 'r', 'LineWidth', 4);
title(['Application of 4nd Order RK Method - Frqeuency Response']);
xlabel('Frequency / Hz');
ylabel('Gain');
saveas(gcf, ['exercise3.frequency.eps'], 'epsc');
% plot decibels
figure;
semilogx(f, 20*log10(abs(Y)/N), 'r', 'LineWidth', 4);
title(['Application of 4nd Order RK Method - Frqeuency Response dB']);
xlabel('Frequency / Hz');
ylabel('Gain (dB)');
saveas(gcf, ['exercise3.frequency.dB.eps'], 'epsc');
 
