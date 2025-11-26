function ELEN133L_Lab4_2(x, y)
    Fs = 8000;
    seg_width = y;
    seg_step = seg_width / 2;
    n_seg = floor((length(x) - seg_width) / seg_step) + 1;
    
    dtmf_freqs = [697 770 852 941 1209 1336 1477];
    
    freqs = (0:seg_width-1) * Fs / seg_width;
    
    [~, freq_indices] = min(abs(freqs' - dtmf_freqs), [], 1);
    
    t_centers = zeros(1, n_seg);
    avg_mag = zeros(1, n_seg);
    dtmf_mags = zeros(7, n_seg);
    
    nstart = 1;
    for k = 1:n_seg
        n1 = nstart;
        n2 = nstart + seg_width - 1;
        if n2 > length(x)
            break;
        end
        
        x_seg = x(n1:n2);
        X = abs(fft(x_seg));
        
        t_centers(k) = 0.5 * (n1 + n2) / Fs;
        
        avg_mag(k) = mean(X);
        
        dtmf_mags(:, k) = X(freq_indices);
        
        nstart = nstart + seg_step;
    end
    
    figure;
    subplot(2,1,1);
    plot(t_centers, avg_mag, 'k');
    xlabel('Time (s)');
    ylabel('Avg Magnitude');
    title('Average FFT Magnitude per Segment');
    
    subplot(2,1,2);
    plot(t_centers, dtmf_mags');
    xlabel('Time (s)');
    ylabel('Magnitude');
    legend("697 Hz", "770 Hz", "852 Hz", "941 Hz", "1209 Hz", "1336 Hz", "1477 Hz");
    title('DTMF Frequency Bin Magnitudes');


end