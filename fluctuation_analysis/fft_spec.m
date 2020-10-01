function [signal_dblc_fft, f] = fft_spec(signal, fs, mode)
nlength = length(signal);

if mode == 1
    signal_dbl = cat(1, signal, signal);
elseif mode == 2
    signal_dbl = cat(1, signal, fliplr(signal));
end

if (mode == 1) || (mode == 2)
    signal_dbl_fft = fft(signal_dbl);
    signal_dblc_fft = signal_dbl_fft(1:2:2*nlength)/2;
    f = (0:nlength-1)*(fs/nlength);
    f = f';
end

if (mode == 3)
    signal_dblc_fft = fft(signal);
    f = (0:nlength-1)*(fs/nlength);
    f = f';
end

end