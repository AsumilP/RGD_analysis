# RGD_analysis

# fluctuation_analysis

Codes to deal with time-series fluctuation analyses, which are mainly written by MATLAB and Python.

## Demo

Coming soon.

## Description

- Filtering temporal pressure data and confirming changes of the fluctuation magnitudes.
1. filtered_p_prime_rms.m, band_pass_filter.m, fft_spec.m
2. rms_transition_time.m

- Calculation for averaged power spectra.
1. (p') filtered_p_prime_rms.m, band_pass_filter.m, fft_spec.m
2. spectra_mean.m, fft_meanspec.m, fft_spec.m
3. spectra_mean_av_plot.m

- Calculation for phase difference changes between two signals. (e.g. I' v.s. p' v' v.s. p' p' v.s. p')
1. (p') filtered_p_prime_rms.m, band_pass_filter.m, fft_spec.m
2. crosscorreletion_sequence.m
3. crosscorreletion_sequence_av_plot.m

- Confirmation on the systematic response with a specific input. (e.g. excitation)
1. speaker_response.m, band_pass_filter.m, fft_meanspec.m, fft_spec.m, trace_frequency.m

- Estimation of the eigen frequencies of combustion oscillation in a cuboid combustor.
1. combustion_oscillation_freq.m



# piv

Codes to deal with PIV experimental processing, which are mainly written by MATLAB.

## Demo

Coming soon.

## Description

- Visualization for time-series SPIV and pressure fluctuations data with a specific time. e.g. transition section
1. u_v_w_velo_press_image_gif.m, squiver_pres.m, ncquiverref2.m, skip_frames.m, MyColormap_for_w.mat





## Requirement

- Development environment -MATLAB
1. MATLAB ver. 9.7 (R2019b)
2. Mapping Toolbox ver. 4.9 (R2019b)
3. Parallel Computing Toolbox ver. 7.1 (R2019b)
4. Signal Processing Toolbox ver. 8.3 (R2019b)

## Contribution







## Author
