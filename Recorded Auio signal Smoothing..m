clc;
clear;
close all;

samplerate = 16000;
myAudio = audiorecorder(samplerate,8,1);
recordblocking(myAudio, 2);

recording = getaudiodata(myAudio);

%% audio write


%smoothA = smooth(recording, samplerate);
%smoothB = smooth(recording, samplerate/2);
%smoothC = smooth(recording,samplerate/4);
%smoothD = smooth(recording,samplerate*.1);

Z = [1, zeros(1,samplerate), 1, zeros(1, samplerate),1, zeros(1,samplerate),1];


gefaltet = conv(Z, recording);

%%play(myAudio);
soundsc(gefaltet,samplerate);
%soundsc(recording,samplerate);
