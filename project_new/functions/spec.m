% spectrum: derive the periodogram of the input signal
% s: the input signal
% fs: sampling rate
% m: distance between two frames
% n: number of samples per frame
% output spec: spectrum
%%%%%%%%%
function spec = spec(s, fs, m, n)
%pre-emphasis
b=[1 -0.95];
H=freqz(b,1,'whole',length(s));
S=fft(s);
ES=S.*H;
s=ifft(ES);
%frame blocking
Nframes = floor(( length(s) - n) / m) + 1;%number of total frames
for i = 1:n
    for j = 1:Nframes
        F(i, j) = s(((j - 1) * m) + i); %F(i,j) is the ith element in the jth frame
    end
end
%windowing
w = hamming(n);%w is the hamming window
Fw = diag(w) * F;%implement windowing
%fft
for i = 1:Nframes
    spec(:, i) = fft(Fw(:, i)); %implement fft on each frame(STFT)
end

end