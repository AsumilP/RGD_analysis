function [signal_bps] = band_pass_filter(signal, fs, lpsfreq, hpsfreq, mode)
nlength = length(signal);
[signal_fft, f] = fft_spec(signal, fs, mode);

for i = 1:nlength
    if (fs/2-abs(f(i)-fs/2) <= lpsfreq) && (fs/2-abs(f(i)-fs/2) >= hpsfreq)
        signal_fft(i) = signal_fft(i);
    elseif (fs/2-abs(f(i)-fs/2) > lpsfreq) || (fs/2-abs(f(i)-fs/2) < hpsfreq)
        signal_fft(i) = 0;
    end
end

signal_bps = ifft(signal_fft);
end