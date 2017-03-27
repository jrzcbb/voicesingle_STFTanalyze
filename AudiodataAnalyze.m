%%
clear all;
close all;
clc;
%%
[Audiodata FS] = audioread('C:\Users\jiaor\Desktop\时频信号分析\你好.m4a');
SingleWayAudio = Audiodata(:,1);
Timelength = length(SingleWayAudio)/FS;
Time = linspace(0,Timelength,length(SingleWayAudio));
plot(Time,SingleWayAudio);title('发音：你好(归一化幅度)');xlabel('时间/S');
%sound(SingleWayAudio,FS);
%%
STFT = [];
FFTRate = 1024;
for i = 1:32:length(SingleWayAudio)-FFTRate
    STFT(fix(i/32)+1,:) = real(fftshift(fft(SingleWayAudio(i:i+FFTRate-1).*kaiser(FFTRate,2.5),FFTRate)));
end
%%
STFT = abs(STFT);
[value pos] = max(max(STFT));
STFT = STFT/value;
STFT = STFT';
Time = linspace(0,Timelength,3936);
Freq = linspace(0,8000,1024);
contour(Time,Freq,STFT);title('时频图'),xlabel('时间/s');ylabel('频率/Hz');
