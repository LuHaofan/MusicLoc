clear; clc;

%% read the transmitted signal and received signal

[music, Fs] = audioread('../music.wav');
[recv, Fs] = audioread('../High_SNR.wav');

%% truncate the signal and select the channel
music_ch1 = music(1:Fs*10,1);
recv_ch1 = recv(Fs*2.5:Fs*14.5, 1);
recv_ch2 = recv(Fs*2.5:Fs*14.5, 2);

%% align the signals
[align_music, temp] = alignsignals(music_ch1, recv_ch1);
align_recv = temp(1:length(align_music));
%% Plot the channel 1 of the music and channel 1 of received signal for analysis
ax(1) = subplot(3,1,1);
plot(align_music);
ylabel('Music');

ax(2) = subplot(3,1,2);
plot(align_recv);
ylabel('Ch1 recv');

%% Estimate the channel and plot the Channel impulse response
cir = ifft(fft(align_music)./fft(align_recv));
ax(3) = subplot(3,1,3);
plot(cir);
ylabel('CIR');
linkaxes(ax,'x');
pause;

%% Do the same thing for channel 2
[align_music, temp] = alignsignals(music_ch1, recv_ch2);
align_recv = temp(1:length(align_music));

ax(1) = subplot(3,1,1);
plot(align_music);
ylabel('Music');

ax(2) = subplot(3,1,2);
plot(align_recv);
ylabel('Ch1 recv');

cir = ifft(fft(align_music)./fft(align_recv));
ax(3) = subplot(3,1,3);
plot(cir);
ylabel('CIR');
linkaxes(ax,'x');
pause;