clc;
clear;
close all;

%% import
video = VideoReader('fingerPuls.mp4');
video.CurrentTime = 0;
video_length_s = 30;

%% extract data
video_avg_brightness = zeros([1 video.NumFrames]);

video.CurrentTime = 0;
frame_index = 1;
min_brightness = 255;

disp("Begin averaging...")
while hasFrame(video)
    F = readFrame(video);

    F_bw = mean(F, 3);
    F_brightness = mean(F_bw, "all");
    video_avg_brightness(frame_index) = F_brightness;
    frame_index = frame_index + 1;
    if F_brightness < min_brightness
        min_brightness = F_brightness;
    end
end
disp("Done averaging.")

sampling_freq =  video.NumFrames / video_length_s;


%% plot
video_time_seconds = linspace(0, video_length_s, video.NumFrames);
video_avg_brightness_offset = video_avg_brightness - min_brightness;


%% filter
cutoff_freq = 2.5;  
sampling_rate = 1 / mean(diff(video_length_s));
sampling_rate = video.NumFrames / video_length_s;

% Design the low-pass filter
filter_order = 4; 
normalized_cutoff_freq = cutoff_freq / (sampling_rate / 2);
[b, a] = butter(filter_order, normalized_cutoff_freq, 'low');

% Apply the low-pass filter to the average brightness values
video_avg_brightness_filtered = filtfilt(b, a, video_avg_brightness_offset);

%video_avg_brightness_filtered = smoothdata(video_avg_brightness_offset);

%% calc bpm

plot(video_time_seconds, video_avg_brightness_offset);
xlabel("time [s]");
ylabel("Avg. Brightness");
%findpeaks(video_avg_brightness_offset)

%findpeaks(video_avg_brightness_filtered, 'MinPeakHeight', 0.2, 'MinPeakDistance', 50); 

[pks,locs,w,p] = findpeaks(video_avg_brightness_filtered, 'MinPeakDistance', 50);
plot(video_avg_brightness_filtered)
hold on
plot(locs,pks,'x')

mean(w);
bpm = length(pks) * (60 / video_length_s)
