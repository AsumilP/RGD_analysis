function [fchange] = trace_frequency(signal, fs, taxis, lpsfreq_signal, hpsfreq_signal, bps_lpsfreq, bps_hpsfreq, mode)
datasize = length(signal);
ts = 1/fs;
[pks, locs] = findpeaks(signal);
TF = islocalmin(signal);
nn = 0;

for t = 1:datasize
    if TF(t) == 1
        nn = nn+1;
        locs2(nn) = t;
    end
end

locs = reshape(locs,[length(locs) 1]);
locs2 = reshape(locs2,[nn 1]);
peaknumber = sort(cat(1,locs,locs2));
nn = 0;

for t = 1:length(peaknumber)-1
    localfreq(t) = 1/(2*ts*(peaknumber(t+1)-peaknumber(t)));
    if (localfreq(t) <= lpsfreq_signal) && (localfreq(t) >= hpsfreq_signal)
        nn = nn+1;
        taxis_prespk(nn) = (ts*(peaknumber(t)+peaknumber(t+1))/2);
        localfreq_pres(nn) = localfreq(t);
     end
end

fchange = pchip(taxis_prespk,localfreq_pres,taxis);
fchange = reshape(fchange,[length(fchange) 1]);
[fchange] = band_pass_filter(fchange, fs, bps_lpsfreq, bps_hpsfreq, mode);
end
