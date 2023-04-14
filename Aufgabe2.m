

%% 1.Import data und Variable decleration
DataIn = readtable('Schritte.csv');
time = DataIn.Time_s_;
Accx = DataIn.AccelerationX_m_s_2_;
Accy = DataIn.AccelerationY_m_s_2_;
Accz = DataIn.AccelerationZ_m_s_2_;
AcAbs = DataIn.AbsoluteAcceleration_m_s_2_;

%%2. Bestimmung des AbsatzFrequenz.
dt = mean(diff(time));
y = linspace(time(1),time(end),length(time));

%% 3 Plot in X richtung

plot(time,Accx);
xlabel("Zeit");
ylabel("Accerlation");

%%4 
data_begin_index = find(time>=12.43 ,1);
data_end_index = find(time>=131.03 ,1);

Time_Slice=y(data_begin_index:data_end_index);
AccX_Slice=Accx(data_begin_index:data_end_index); 

AccY_Slice=Accy(data_begin_index:data_end_index);
AccZ_Slice=Accz(data_begin_index:data_end_index);
AccAbs_Slice=AcAbs(data_begin_index:data_end_index);
%plot
subplot(5,1,1)
plot(Time_Slice,AccX_Slice);
xlabel("Zeit");
ylabel("Accerlation X");

subplot(5,1,2)
plot(Time_Slice,AccY_Slice);
xlabel("Zeit");
ylabel("Accerlation Y");

subplot(5,1,3)
plot(Time_Slice,AccZ_Slice);
xlabel("Zeit");
ylabel("Accerlation Z");

subplot(5,1,4)
plot(Time_Slice,AccAbs_Slice);
xlabel("Zeit");
ylabel("Accerlation Abs");
%% f und g betrag berechnen 
AccAbsCalc_Slice = sqrt(AccX_Slice.^2+AccY_Slice.^2+AccZ_Slice.^2)
AccAbsDiff_Slice = abs(AccAbsCalc_Slice-AccAbs_Slice)

%subplot(5,1,5)
%plot(Time_Slice,AccAbsDiff_Slice);
% xlabel("Zeit");

%ylabel("Accerlation Abs Diff");
%% h smoothing the data
subplot(5,1,5)
AccAbs_Smooth_Slice = smoothdata(smoothdata(smoothdata(AccAbs_Slice)))
plot(Time_Slice,AccAbs_Smooth_Slice)


%% g fidning peaks

[peaks,locs] = findpeaks(AccAbs_Smooth_Slice,MinPeakHeight=10)
steps = length(peaks)


%% PLOTTING PEAKS
plot(Time_Slice,AccAbs_Smooth_Slice,Time_Slice(locs),peaks,'r*')
