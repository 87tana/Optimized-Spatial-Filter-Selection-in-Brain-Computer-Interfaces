%%% practical project

noiseLevel = 0;
maxSig = 1;
minSig = 0;

% 1) Make a copy of the general model (MyHandScout)
updatedMyHandScout = MyHandScout;

% updatedModel.ImageGridAmp=zeros(size(updatedModel.ImageGridAmp));
% or
% 2) Make the ImageGridAmp (the amplitude of all veritces) equal to 0.
updatedMyHandScout.ImageGridAmp = 0*updatedMyHandScout.ImageGridAmp;  

% 3) Set the vertices located in the identified hand knob area equal to 1.
signal = 1e-6*ones(size(updatedMyHandScout.ImageGridAmp(PerhapsMyHandknob.Vertices,:)));

%%%% If the noise only applied to the hand knob area.
%%% rand(n)--> Create a matrix of size n with random values in [0,1].
%%% (1e-6*minSig + 1e-6*(maxSig-minSig) --> Scale the random values
%%% between the maximum and minimum of the simulated signal.
% noiseSig = (1e-6*minSig + 1e-9*(maxSig-minSig)*rand(size(updatedMyHandScout.ImageGridAmp(PerhapsMyHandknob.Vertices,:))));

%%% Summing the signal and noise.
%%% noiseLevel --> determine the influence of the noise in the signal. 
% updatedMyHandScout.ImageGridAmp(PerhapsMyHandknob.Vertices,:) = signal+noiseLevel*noiseSig;

%%%% If the noise applied to the whole brain.
% rand(n)--> Create a matrix of size n with random values in [0,1].
% (1e-6*minSig + 1e-6*(maxSig-minSig) --> Scale the random values
% between the maximum and minimum of the simulated signal.
noiseSig = (1e-6*minSig + 1e-6*(maxSig-minSig)*rand(size(updatedMyHandScout.ImageGridAmp)));
% Summing the signal and noise.
% noiseLevel --> determine the influence of the noise in the signal.
% Add the signal to the hand knob.
updatedMyHandScout.ImageGridAmp(PerhapsMyHandknob.Vertices,:) = signal; 
% Add noise to the whole brain vertices
updatedMyHandScout.ImageGridAmp = updatedMyHandScout.ImageGridAmp + noiseLevel*noiseSig;


% 4) Rename the comment
updatedMyHandScout.Comment = 'MN: EEG(Full,Constr)_left-v-right c08 lh';

