function [abs_signal_fft, av_angle_fft, f, div_nlength] = fft_meanspec(signal, fs, tlength, div_inc, fftmode, psmode)
nlength = length(signal);
abs_signal_fft = 0;
av_angle_fft = 0;

if psmode == 1
    % sequential
    div_nlength = fs*tlength;
    div_num = floor(nlength/div_nlength);
    for k = 1:div_num
        signal_div = signal((k-1)*div_nlength+1:k*div_nlength);
        [signal_fft, f] = fft_spec(signal_div, fs, fftmode);
        abs_signal_fft = abs_signal_fft + abs(signal_fft)/div_num;
        % av_angle_fft = av_angle_fft + unwrap(angle(signal_fft))/div_num;
        av_angle_fft = av_angle_fft + angle(signal_fft)/div_num;
    end

elseif psmode == 2
    % thining out
    div_nlength = floor(1+(tlength*fs-1)/(div_inc+1));
    div_num = nlength - (div_inc+1)*(div_nlength-1);
    for k = 1: divnum
        signal_div = signal(k:(div_inc+1):k+(div_inc+1)*(div_nlength-1));
        [signal_fft, f] = fft_spec(signal_div, fs/(div_inc+1), fftmode);
        abs_signal_fft = abs_signal_fft + abs(signal_fft)/div_num;
        % av_angle_fft = av_angle_fft + unwrap(angle(signal_fft))/div_num;
        av_angle_fft = av_angle_fft + angle(signal_fft)/div_num;
    end
end

% abs_signal_fft = (abs_signal_fft).^(0.5);
end
