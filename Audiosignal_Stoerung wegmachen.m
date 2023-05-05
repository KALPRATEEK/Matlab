clc;
clear;
close all;

%% import
[beep, beep_samplerate]  = audioread("male2_beep.wav");
[noise, noise_samplerate] = audioread("male2_noise.wav");

% 127388 Datenpunkte, 16kHz

%% c) play audio
%soundsc(beep,beep_samplerate);

%% d) Spektrum
% Die Störung ist bei 3,2 kHz

%% e)
beep_smooth = smooth(beep, 5);
y = fft(beep_smooth);

fs = beep_samplerate;
n = length(beep);          % number of samples
f = (0:n-1)*(fs/n);     % frequency range
power = abs(y).^2/n;    % power of the DFT

plot(f,power)
xlabel('Frequency')
ylabel('Power')

plot(beep)

%signal = beep(:,1);
%plot(psd(spectrum.periodogram,signal,'Fs',beep_samplerate,'NFFT',length(signal)));

soundsc(beep_smooth,beep_samplerate);

%% audio write
%soundsc(beep_smooth,beep_samplerate);
audiowrite("male2_beep_smooth.wav", beep, beep_samplerate);

