function mono = stereo_to_mono(stereo)
   [i, j] = size(stereo);

  % Initializare vector mono
  mono = zeros(i, 1);

  % formula din task
  for i = 1 : i
      mono(i) = sum(stereo(i, :)) / j;
  end

  % normalizarea
  mono = mono / max(abs(mono));
endfunction

