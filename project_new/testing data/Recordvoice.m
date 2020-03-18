r=audiorecorder(12500,16,1);
disp('Ready...');
pause(1.5);
disp('Start speaking.');
recordblocking(r,2);
disp('End of Recording.');
y=getaudiodata(r);