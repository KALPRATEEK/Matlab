clc;           % Clears the Command Window
clear;         % Clears all variables from the workspace
close all;     % Closes all figure windows

%% setup
% for testing diffrent frequencies with sinus function
freq_f1 = 1000;     % Frequency of f1 (in Hz)
freq_f2 = 4000;     % Frequency of f2 (in Hz)
freq_f3 = 5000;     % Frequency of f3 (in Hz)
freq_f4 = 20000;    % Frequency of f4 (in Hz)

samplerate = 20000; % Sampling rate (in Hz)

%frequency =

%% vector

h = [1, zeros(1, 100)]; % Creates a vector 'h' with 101 elements, where the first element is 1 and the rest are zeros

tv = linspace(0, 0.01, 321); % Creates a time vector 101 'tv' with  evenly spaced points between 0 and 0.01

t = linspace(1, 100, 20020); % Creates a time vector 't' with 20020 evenly spaced points between 1 and 100

hn = unknownFilter(h); % Applies an unknown filter to the vector 'h' and assigns the result to 'hn'plot(hn);
hn_extended = [hn, zeros(1, numel(t)-numel(hn))]; 

figure() 
%plot(hn)
plot(t, hn_extended);
xlabel('Zeit (s)');
ylabel('h[n]');
title('Stoßantwort');

%% amplitude

y = fft(hn); % Computes the Discrete Fourier Transform (DFT) of 'hn' using the Fast Fourier Transform (FFT) algorithm and assigns it to 'y'

fs = samplerate;                 % Assigns the sampling rate to 'fs'
n = length(hn);                  % Assigns the number of samples in 'hn' to 'n'
f = (0:n-1)*(samplerate/n);      % Creates a frequency range vector 'f' based on the sampling rate and the number of samples
power = abs(y).^2/n;             % Computes the power spectrum of 'y'

figure()
plot(f,power)
xlabel('Frequency')
ylabel('Power')

%% generate sine wave

sine_f = sineWave(freq_f2, 0.01, samplerate); % Generates a sine wave with frequency 'freq_f2', duration 0.01 seconds, and the given sampling rate
sine_f_conv = conv(hn, sine_f);               % Performs convolution between 'hn' and 'sine_f' and assigns the result to 'sine_f_conv'

%% plot sine wave
figure()
plot(sine_f);        % Plots the original sine wave
hold on
figure()
plot(sine_f_conv);   % Plots the convolved sine wave
hold off

%% functions

function y = sineWave(frequency, length_s, sample_rate)
    ts=1/sample_rate;             % Calculates the time step based on the sampling rate
    t=0:ts:length_s;              % Creates a time vector 't' with evenly spaced points between 0 and 'length_s'
    y=sin(2*pi*frequency*t);      % Generates a sine wave with the specified frequency, duration, and time vector
end
