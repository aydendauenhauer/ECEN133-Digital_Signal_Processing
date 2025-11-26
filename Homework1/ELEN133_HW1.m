n = 0:59;

q = cos(0.05*pi*n);
r = cos(0.25*pi*n);
s = cos(0.50*pi*n);
v = cos(4.25*pi*n);

figure;

subplot(4,1,1);
stem(n, q, 'filled');
title('q(n) = cos(0.05\pi n)');
xlabel('n'); ylabel('q(n)');
grid on;

subplot(4,1,2);
stem(n, r, 'filled');
title('r(n) = cos(0.25\pi n)');
xlabel('n'); ylabel('r(n)');
grid on;

subplot(4,1,3);
stem(n, s, 'filled');
title('s(n) = cos(0.50\pi n)');
xlabel('n'); ylabel('s(n)');
grid on;

subplot(4,1,4);
stem(n, v, 'filled');
title('v(n) = cos(4.25\pi n)');
xlabel('n'); ylabel('v(n)');
grid on;
