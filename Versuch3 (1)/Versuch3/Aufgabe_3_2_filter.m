clc;           % Clears the Command Window
clear;         % Clears all variables from the workspace
close all;     % Closes all figure windows

%% import audio
[audio, samplerate]  = audioread("Aufgabe_3_2_rec.wav");   % Reads an audio file and assigns the audio data and sampling rate to variables 'audio' and 'samplerate'

%% plot audio
ts = linspace(0, 10, samplerate*10);      % Creates a time vector 'ts' with evenly spaced points from 0 to 10 seconds
figure()
plot(ts, audio);                          % Plots the audio waveform against time
xlabel('Time')
ylabel('Amplitude')

%% frequency
y = fft(audio);                            % Computes the Discrete Fourier Transform (DFT) of the audio signal using the Fast Fourier Transform (FFT) algorithm and assigns it to 'y'
n = length(audio);                         % Assigns the number of samples in 'audio' to 'n'
f = (0:n-1)*(samplerate/n);                % Creates a frequency range vector 'f' based on the sampling rate and the number of samples
power = abs(y).^2/n;                       % Computes the power spectrum of 'y'

figure;
area(f,power)                              % Plots the power spectrum as an area plot
xlabel('Frequency')
ylabel('Power')

%% play modified audio
audio(2:2:end) = [];                       % Removes every other sample from 'audio'
audio(2:2:end) = [];                       % Removes every other sample again
audio(2:2:end) = [];                       % Removes every other sample again
audio(2:2:end) = [];                       % Removes every other sample again
soundsc(audio, samplerate/8, 16);          % Plays the modified audio using 'soundsc' with adjusted sample rate and bit depth

function y = sineWave(frequency, sample_rate)
    x=0:1/sample_rate:1-1/sample_rate;      % Creates a time vector 'x' with evenly spaced points from 0 to 1 second
    y=sin(2*pi*frequency*x);                % Generates a sine wave with the specified frequency and time vector 'x'
end
