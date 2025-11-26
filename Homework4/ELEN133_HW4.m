%% Question 1
N = 2048;
signal_length = 256;
L_values = [5, 25, 125];

for index = 1:length(L_values)
    L = L_values(index);
    x = [ones(1, L), zeros(1, signal_length - L)];
    
    [H, w] = freqz(x, 1, N, 'whole');
    
    figure;
    plot(w, abs(H));
    xlabel('Frequency (rad/sample)');
    ylabel('|X(e^{j\omega})|');
    title(['Magnitude of DTFT for L = ', num2str(L)]);
    grid on;
end

%% Question 6, 1kHz
b = [1, -sqrt(2), 1];
a = [1];
freqz(b, a, 2048, 8000);
title('FIR Notch Filter Frequency Response at 1kHz, fs=8000Hz');

%% Question 6, 11.25kHz
b = [1, -1.696, 1];
a = [1];
freqz(b, a, 2048, 11250);
title('FIR Notch Filter Frequency Response at 1kHz, fs=11250Hz');

%% Question 7
b = [1, -1.414, 1];
a = [1, -1.273, 0.81];
zplane(b, a);
title('Pole-Zero Plot of IIR Notch Filter');
freqz(b, a, 2048, 8000);
title('IIR Notch Filter Frequency Response at 1kHz, fs=8000Hz');
