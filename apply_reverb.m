function signal = apply_reverb(signal, impulse_response)
    % Pas 1 aplicam functia stereo_to_mono
    impulse_mono = stereo_to_mono(impulse_response);

    % Pas 2 produsul de convolutie
    convoluted_signal = fftconv(signal, impulse_mono);

    % Normalizare
    signal = convoluted_signal / max(abs(convoluted_signal));
end
