clc;
clear;
close all;

%% setup audio
record_duration_s = 10;
samplerate = 48000;
recording = audiorecorder(samplerate, 16, 1);

%% record audio

disp('start recording')
recordblocking(recording, record_duration_s);
disp('stopped recording')
recording_data = getaudiodata(recording);

%% save audio
audiowrite("Aufgabe_3_2_rec.wav", recording_data, samplerate)

%% plot audio
plot(recording_data);

%% plot amplitude
recording_data_fft = fft(recording_data);
plot(recording_data_fft);

%% play audio
%play(recording);

