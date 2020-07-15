rad=0.0383; % Radius (m) % 38.3 mm for matrix voice

%M # of theta scanning angles, N # of phi scanning angless, P number of mics
thetaScanningAngles = 0:(2*pi/360):2*pi;
phiScanningAngles = 90; 

P=8; % Number of microphones
s=1; % Number of source signals
noise_var=0;

xPos = [0, -38.13, -20.98, 11.97, 35.91, 32.81, 5.00, -26.57] ./ 38.3;
yPos = [0, 3.58, 32.04, 36.38, 13.32, -19.77, -37.97, -27.58] ./ 38.3;
[gamma, l] = cart2pol(xPos, yPos);

folderName = '90';

[y0,Fs] = audioread(strcat('/Users/profhan/Downloads/' , folderName , '/fmcw_channel_0.wav'));
[y1,Fs] = audioread(strcat('/Users/profhan/Downloads/' , folderName , '/fmcw_channel_1.wav'));
[y2,Fs] = audioread(strcat('/Users/profhan/Downloads/' , folderName , '/fmcw_channel_2.wav'));
[y3,Fs] = audioread(strcat('/Users/profhan/Downloads/' , folderName , '/fmcw_channel_3.wav'));
[y4,Fs] = audioread(strcat('/Users/profhan/Downloads/' , folderName , '/fmcw_channel_4.wav'));
[y5,Fs] = audioread(strcat('/Users/profhan/Downloads/' , folderName , '/fmcw_channel_5.wav'));
[y6,Fs] = audioread(strcat('/Users/profhan/Downloads/' , folderName , '/fmcw_channel_6.wav'));
[y7,Fs] = audioread(strcat('/Users/profhan/Downloads/' , folderName , '/fmcw_channel_7.wav'));

inputSig = [y0 y1 y2 y3 y4 y5 y6 y7];
inputSig = inputSig'; % P by L (L is number of samples)

c = 3.40e2; % Speed of sound (m/s)
fi = 19e3; % center frequency of FMCW from 18kHz - 20 kHz

ebi = steeringVector(xPos, yPos, zPos, gamma, rad, true , fi, c, thetaScanningAngles, phiScanningAngles);
wi = weightingVectorMVDR(inputSig, ebi);
beamformed_Signal = diag(wi) * inputSig;



