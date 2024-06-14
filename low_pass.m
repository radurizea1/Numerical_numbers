function signal = low_pass(x, fs, fc)
    % Pas 1 FFT
    x_FFT = fft(x);
    length_signal = length(x);

    % Ne asiguram ca toate frecventele sunt folosite
    f = (0:length_signal-1) * fs / length_signal;

    % Pas 3 Crearea mastii filtrului
    mask = f <= fc;

    % Pas 4 crearea filtrului
    x_filtered = x_FFT .* mask';

    % Pas 5 aplicarea inversei FFT pentru a primi semnalul propriu-zs
    signal_filtered = ifft(x_filtered);

    % Normalizare
    signal = signal_filtered / max(abs(signal_filtered));
end
