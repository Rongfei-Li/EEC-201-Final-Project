%% read .wav file
Fs = 12500;
[y1,~] = audioread('s1.wav');
[y2,~] = audioread('s2.wav');
[y3,~] = audioread('s3.wav');
[y4,~] = audioread('s4.wav');
[y5,~] = audioread('s5.wav');
[y6,~] = audioread('s6.wav');
[y7,~] = audioread('s7.wav');
[y8,~] = audioread('s8.wav');
[y9,~] = audioread('s9.wav');
[y10,~] = audioread('s10.wav');
[y11,~] = audioread('s11.wav');



%% create Cepstrum from voices signals
N = 256;                % # samples of each frame 
M = 100;                % # samples frame overlaps

Cepstrum1 = mfcc(y1, Fs,M,N);
Cepstrum2 = mfcc(y2, Fs,M,N);
Cepstrum3 = mfcc(y3, Fs,M,N);
Cepstrum4 = mfcc(y4, Fs,M,N);
Cepstrum5 = mfcc(y5, Fs,M,N);
Cepstrum6 = mfcc(y6, Fs,M,N);
Cepstrum7 = mfcc(y7, Fs,M,N);
Cepstrum8 = mfcc(y8, Fs,M,N);
Cepstrum9 = mfcc(y9, Fs,M,N);
Cepstrum10 = mfcc(y10, Fs,M,N);
Cepstrum11 = mfcc(y11, Fs,M,N);
   
%% Create codebooks
L = 16;       % # of centroids 
Codebooks1 = testvq(Cepstrum1,L);
Codebooks2 = testvq(Cepstrum2,L);
Codebooks3 = testvq(Cepstrum3,L);
Codebooks4 = testvq(Cepstrum4,L);
Codebooks5 = testvq(Cepstrum5,L);
Codebooks6 = testvq(Cepstrum6,L);
Codebooks7 = testvq(Cepstrum7,L);
Codebooks8 = testvq(Cepstrum8,L);
Codebooks9 = testvq(Cepstrum9,L);
Codebooks10 = testvq(Cepstrum10,L);
Codebooks11 = testvq(Cepstrum11,L);

%% Create codebook series
Codebook_series = [Codebooks1,Codebooks2,Codebooks3,Codebooks4,Codebooks5...
    ,Codebooks6,Codebooks7,Codebooks8,Codebooks9,Codebooks10,Codebooks11];
