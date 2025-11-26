clear
clc
M = 200;
bw = 20;
fs = 8000;
fc1 = 697;
fc2 = 770;

%% Step 1
Wn1 = [fc1 - bw, fc1 + bw]/(fs/2);
b1 = fir1(M, Wn1, rectwin(M+1));
Wn2 = [fc2 - bw, fc2 + bw]/(fs/2);
b2 = fir1(M, Wn2, rectwin(M+1));

Np = 2048;
[H1, fv1] = freqz(b1,1,Np,fs);
[H2, fv2] = freqz(b2,1,Np,fs);
plot(fv1, abs(H1), fv2, abs(H2))
title('M = 100, bw = 80')
legend('fc1 = 697','fc2 = 770')

%% Step 2
subplot(2,1,1);
plot(b1)

subplot(2,1,2);
plot(b2)

% Run Section 3. How many positive peaks are seen in b1? In b2?
% How is this related to the respective center frequencies?
% There are more peaks for a higher frequency.

% What is the ratio of the value of the center peak in each filter to the
% peak values at the leftmost and rightmost peaks?
% b1: 11.638
% b2: 5.096

%% Step 3
fs = 8000;
tone_len = 0.1;
quiet_len = 0.02;
tone_arr = [1, 4, 7, 3, 6, 9];
n = 6;
dt = 1/fs;

x = ELEN133L_Lab2(tone_len, quiet_len, fs, tone_arr);

time = n * (tone_len + quiet_len);
t_vec = (0:((time * fs) - 1)) * dt;

plot(t_vec, x)
sound(x, fs)

%% Step 4
y1 = filter(b1, 1, x);
y2 = filter(b2, 1, x);

subplot(2,1,1);
plot(y1)

subplot(2,1,2);
plot(y2)

% What is the maximum amplitude for each of the six buttons when filter b1 is used?
% button 1: 0.492074
% button 2: 0.227641
% button 3: 0.0109428
% button 4: 0.495069
% button 5: 0.223422
% button 6: 0.0237141

% When filter b2 is used?
% button 1: 0.227063
% button 2: 0.499374
% button 3: 0.181183
% button 4: 0.22622
% button 5: 0.497263
% button 6: 0.177108

% How do you explain the differences?
% Different filters with different center frequencies.

% Is there any noticeable dependance of the amplitudes on which column frequency
% was present for the six buttons?
% Yes, button 1 is 697 Hz and has the highest ampltitude on y1 which was
% filtered using b1 which was cenetered at 697 Hz

%% Step 5
y1a = abs(y1);
y2a = abs(y2);

subplot(3,2,1);
plot(y1a)

subplot(3,2,2);
plot(y2a)

smoothLength = 20;
bma = (ones(1,smoothLength))/smoothLength;
y1s = filter(bma, 1, y1a);
y2s = filter(bma, 1, y2a);

subplot(3,2,3);
plot(y1s)

subplot(3,2,4);
plot(y2s)

% How many cycles of a signal with frequency fc1 would there be in 20 samples?
% 3.35

% Observe the plots for y1s and y2s, and determine the lowest value you could select for a
% threshold to always have a 1 for the corresponding row frequency and never have a 1 for
% any of the other 6 frequencies
% 0.3

% Determine the highest value for a threshold that would never give a zero result when the
% corresponding frequency was present
% 0.15

y1t = logic_function(y1s);
y2t = logic_function(y2s);

subplot(3,2,5);
plot(y1t)

subplot(3,2,6);
plot(y2t)

%% Step 6
% When changing M to 26, the signals are not filtered as much which caused
% more logic 1's than when M was 100

% When changing M to 200 and bw to 20 it cut off values outside of the
% center frequency much more. It resulted in the same logic 1's as when M
% was 100 and bw was 80.

% Did increasing the filter length to 200 result in a narrower filter?
% Yes, increasing the filter length resu;ted in a narrower filter.

%% Step 7
aa = 4;
testsign = y1 + aa*randn(1, length(y1));
plot(aa*randn(1, length(y1)))
sound(testsign)

testsign1 = filter(b1, 1, testsign);

subplot(2,1,1);
plot(testsign1)

testsign1a = abs(testsign1);
subplot(3,2,1);
plot(testsign1a)

testsign1s = filter(bma, 1, testsign1a);

subplot(3,2,3);
plot(testsign1s)

testsign1t = logic_function(testsign1s);

subplot(3,2,5);
plot(testsign1t)

% When aa is increased to above 1 the threshold value starts to fail.


function result = logic_function(signal)
    my_threshold = (0.3 + 0.15) / 2;
    result = signal > my_threshold;
end