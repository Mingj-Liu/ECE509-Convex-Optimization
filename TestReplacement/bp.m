% Test Replacement Project Qb BP

clear
clc

f0 = 1; % Fundamental Frequency
t = 0:1e-3:1; % Time Axis

n = randperm(30, 15).';
a = rand(15, 1);
b = rand(15, 1);

% Noise Generation
snr = 10;
noise = randn(size(t));
noise = noise - mean(noise);
signal_power = 1 / length(t)*sum(t.^2);
noise_variance = signal_power / ( 10^(snr/10) );
noise = sqrt(noise_variance) / std(noise)*noise;

y = sum(a.*cos(2*pi*f0*n*t) - b.*cos(2*pi*f0*n*t)) + noise;
f = cos(2*pi*f0*((1:30).')*t);

cvx_begin 
variables x(1,30) 
%minimize sum((x*f - y).^2) + 1*norm(x,1)
minimize sum((x*f - y).^2) + 10*norm(x,1)
%minimize sum((x*f - y).^2) + 100*norm(x,1)
cvx_end

% Reoptimize problem over nonzero coefficients
sp = find(abs(x)>1e-5); 
f1 = f(sp,:);

cvx_begin
variables x1(1,length(sp))
minimize sum((x1*f1 - y).^2)
cvx_end

%plot signal over time
figure,
plot(t, y, '-'),
hold on
plot(t, x1*f1, '--r'),
xlabel('time'), ylabel('amplitude');
legend('Original Signal','Reconstructed Signal')

%calculate and plot error over time
error = abs(x1*f1 - y);
figure,
plot(t, error),
xlabel('time'), ylabel('error');
error_n = sum((x1*f1 - y).^2) / sum(y.^2);
disp(error_n);

%original and recovered coefficients
a_o = a;
b_o = b;
x_r = [sp; x1].';
save('coefficients.mat','a_o', 'b_o', 'x_r')