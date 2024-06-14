function x = oscillator(freq, fs, dur, A, D, S, R)
    % Generare vector de timp
    t = (0 : 1 / fs : dur)';  % Vectorul timp t, cu pasul de esantionare 1/fs

    % Generare sinusoida
    sinusoid = sin(2 * pi * freq * t);  % Sinusoida cu frecventa 'freq'

    % Calculul numarului de eșantioane pentru fiecare fază ADSR
    attack_samples = floor(A * fs);  % Numărul de eșantioane pentru atac
    decay_samples = floor(D * fs);   % Numărul de eșantioane pentru descompunere
    release_samples = floor(R * fs); % Numărul de eșantioane pentru eliberare
    total_samples = length(t);       % Numărul total de eșantioane în timpul 't'
    sustain_samples = total_samples - (attack_samples + decay_samples + release_samples); % Numărul de eșantioane pentru susținere

    % Construirea envelopei ADSR
    attack_env = linspace(0, 1, attack_samples)';     % Atac: creștere de la 0 la 1
    decay_env = linspace(1, S, decay_samples)';       % Descompunere: scădere de la 1 la S
    sustain_env = S * ones(sustain_samples, 1);       % Susținere: valoare constantă S
    release_env = linspace(S, 0, release_samples)';   % Eliberare: scădere de la S la 0
    envelope = [attack_env; decay_env; sustain_env; release_env]; % Concatenarea fazelor într-un singur vector envelope

    % Ajustarea lungimii envelopei la lungimea totală a vectorului de timp
    if length(envelope) > total_samples
        envelope = envelope(1 : total_samples); % Se taie excesul de eșantioane
    elseif length(envelope) < total_samples
        envelope = [envelope; zeros(total_samples - length(envelope), 1)]; % Se adaugă zero-uri dacă este nevoie
    end

    % Aplicarea envelopei ADSR asupra sinusoidului (modulare)
    x = sinusoid .* envelope;  % Modularea sinusoidului cu envelope-ul ADSR
end

