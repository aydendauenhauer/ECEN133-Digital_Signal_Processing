function dial_sig = ELEN133L_Lab2(tone_time, quiet_time, fs, dial_vals)
% dial_sig = my_dtmf(tone_time, quiet_time, fs, dial_vals)
% 
% INPUTS:
%   tone_time  - Duration of each DTMF tone in seconds
%   quiet_time - Duration of silence between tones in seconds
%   fs         - Sampling frequency in Hz
%   dial_vals  - Vector of integers (1 to 12) representing keypad buttons
%                Button 10 = '*', 11 = '0', 12 = '#'
%
% OUTPUT:
%   dial_sig   - Normalized signal vector of DTMF tones for dial_vals
%                Output is scaled so max(abs(dial_sig)) = 1

    % DTMF frequencies (Hz)
    row_freqs = [697, 770, 852, 941];     % Rows: 1-4
    col_freqs = [1209, 1336, 1477];       % Columns: 1-3

    % Button-to-row/column mapping (row, column)
    % Index represents button value (1 to 12)
    dtmf_map = [1 1; 1 2; 1 3;    % 1, 2, 3
                2 1; 2 2; 2 3;    % 4, 5, 6
                3 1; 3 2; 3 3;    % 7, 8, 9
                4 1; 4 2; 4 3];   % *, 0, #

    tone_len = round(fs * tone_time);        % Samples per tone
    quiet_len = round(fs * quiet_time);      % Samples per quiet segment
    n = (0:tone_len-1) / fs;                 % Time vector for one tone
    quiet_sig = zeros(1, quiet_len);         % Silence vector

    dial_sig = [];                           % Initialize output

    for k = 1:length(dial_vals)
        button = dial_vals(k);
        
        % Check if button is valid
        if button < 1 || button > 12
            warning('Skipping invalid button value: %d', button);
            continue;
        end
        
        % Get corresponding row and column indices
        row = dtmf_map(button, 1);
        col = dtmf_map(button, 2);
        
        % Frequencies for this button
        f1 = row_freqs(row);
        f2 = col_freqs(col);
        
        % Generate tone as sum of two cosines
        tone = cos(2*pi*f1*n) + cos(2*pi*f2*n);
        
        % Append tone and quiet to output signal
        dial_sig = [dial_sig, tone, quiet_sig];
    end

    % Normalize output signal
    if max(abs(dial_sig)) > 0
        dial_sig = dial_sig / max(abs(dial_sig));
    end
end
