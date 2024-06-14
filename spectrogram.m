function [S, f, t] = spectrogram(signal, fs, window_size)
    % Lungimea semnalului
    L = length(signal);

    % Calculează suprapunerea și pasul pentru ferestre
    overlap = window_size / 2;
    step = window_size - overlap;

    % pasul 1 din task
    num_windows = floor((L - window_size) / step) + 1;

    % Pregătește matricea pentru spectogramă și vectorii de frecvență și timp
    full_S = zeros(512, num_windows);
    f = (0 : 511)' * (fs / window_size);  % vectorul de frecvențe pentru FFT de 1024 puncte (utilizăm doar jumătate plus componenta DC)
    t = (0 : num_windows - 1) * (step / fs);  % vectorul de timp bazat pe mărimea pasului

    % Funcția de fereastră (fereastra Hann)
    window_func = hanning(window_size);

    % Calculează spectograma
    for k = 1 : num_windows
        % Indicii de start și sfârșit pentru fereastra curentă
        start_index = (k - 1) * step + 1;
        end_index = start_index + window_size - 1;

        % Completare cu zero dacă este necesar
        if end_index > L
            windowed_signal = [signal(start_index : L); zeros(end_index - L, 1)];
        else
            windowed_signal = signal(start_index : end_index);
        end

        windowed_signal = windowed_signal .* window_func;

        % Calculează FFT și păstrează doar frecvențele pozitive
        fft_result = fft(windowed_signal, 1024);
        full_S(:, k) = abs(fft_result(1 : 512));
    end

    % Ajustarea parametrilor astfel incat safie corespunzatori cerintei
    S = full_S(:, 1 : 2 : end);
    t = t(1 : 2 : end);
    f = f / 2;
    t = t';
end
