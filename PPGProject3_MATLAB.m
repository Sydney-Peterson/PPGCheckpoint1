
%load and use signal analyzer to smooth and put in a bandpass filter
%%Done once to get timetables

%load('Project3PPGExerciseBreathing90SecondsTrial1.mat')
%signalAnalyzer(Project3PPGExerciseBreathing90SecondsTrial1)

%load('Project3PPGExerciseBreathing90SecondsTrial2.mat')
%signalAnalyzer(Project3PPGExerciseBreathing90SecondsTrial2)

%load('Project3PPGExerciseBreathing90SecondsTrial3.mat')
%signalAnalyzer(Project3PPGExerciseBreathing90SecondsTrial3)

%load('Project3PPGHoldingBreathing90Seconds.mat')
%signalAnalyzer(Project3PPGHoldingBreathing90Seconds)

%load('Project3PPGNormalBreathing90seconds.mat')
%signalAnalyzer(Project3PPGNormalBreathing90seconds)

%%Changing from timetable to double
% Trial 1
ppg_ex1_tt = Project3PPGExerciseBreathing90SecondsTrial1;
Fs_ex1  = ppg_ex1_tt.Properties.SampleRate;
ppg_ex1_filt = ppg_ex1_tt.A0_A0;
ppg_ex1_filt = ppg_ex1_filt(:);

% Trial 2
ppg_ex2_tt = Project3PPGExerciseBreathing90SecondsTrial2;
Fs_ex2  = ppg_ex2_tt.Properties.SampleRate;
ppg_ex2_filt = ppg_ex2_tt.A0_A0;
ppg_ex2_filt = ppg_ex2_filt(:);

% Trial 3
ppg_ex3_tt = Project3PPGExerciseBreathing90SecondsTrial3;
Fs_ex3  = ppg_ex3_tt.Properties.SampleRate;
ppg_ex3_filt = ppg_ex3_tt.A0_A0;
ppg_ex3_filt = ppg_ex3_filt(:);

% Holding breath
ppg_hold_tt = Project3PPGHoldingBreathing90Seconds;
Fs_hold  = ppg_hold_tt.Properties.SampleRate;
ppg_hold_filt = ppg_hold_tt.A0_A0;
ppg_hold_filt = ppg_hold_filt(:);


save('ppg_ex1_filt.mat','ppg_ex1_filt','Fs_ex1')
save('ppg_ex2_filt.mat','ppg_ex2_filt','Fs_ex2')
save('ppg_ex3_filt.mat','ppg_ex3_filt','Fs_ex3')
save('ppg_hold_filt.mat','ppg_hold_filt','Fs_hold')

%variability
hrv_ex1 = hrvFromPPG(ppg_ex1_filt, Fs_ex1); %EX trial 1
hrv_ex2 = hrvFromPPG(ppg_ex2_filt, Fs_ex2);
hrv_ex3 = hrvFromPPG(ppg_ex3_filt, Fs_ex3);
hrv_hold = hrvFromPPG(ppg_hold_filt, Fs_hold);

%display them
hrv_ex1.SDNN, hrv_ex1.RMSSD
hrv_ex2.SDNN, hrv_ex2.RMSSD
hrv_ex3.SDNN, hrv_ex3.RMSSD
hrv_hold.SDNN, hrv_hold.RMSSD

%make a table of heart rate variability (HRV)
conds = {'Ex1';'Ex2';'Ex3','Hold'};
SDNN = [hrv_ex1.SDNN; hrv_ex2.SDNN; hrv_ex3.SDNN; hrv_hold.SDNN];
RMSSD = [hrv_ex1.RMSSD; hrv_ex2.RMSSD; hrv_ex3.RMSSD; hrv_hold.RMSSD];

HRV_table = table(conds, SDNN, RMSSD, ...
    'VariableNames', {'Condition', 'SDNN_s', 'RMSSD_s'})