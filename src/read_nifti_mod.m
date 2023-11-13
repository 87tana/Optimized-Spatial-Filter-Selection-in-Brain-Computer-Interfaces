%%%%% Script to read from nifti file and create a scout based on a
%%%%% threshold
%%%%% Befor runnig the script, export the cortex from BrainStorm to Matlab 
%%%%% and name it 'sSurf'.

% Path to the nifti file reader toolbox
addpath('/home/rezatannaz/Softwares/toolbox_matlab_nifti');

%% Setup

% Path to the freesurfer's data
mainPath = '/home/rezatannaz/Data/Project/subject01';   
% Path to the anatomy in the BrainStorm's database.
path2bsAnatomy = '/home/rezatannaz/Data/brainstorm_db/hand_execution/anat';
subject = 'c01';                         % subject name (in BrainStorm)
sess = 'Session01';                     % Session
Analysis = 'my_handexecution.sm05.rh';  % Analysis
conts = 'left-v-right';                 % Contrast
LoR = 'RH';                             % LH or RH
LowThre = 2;                            % Low threshold 
UpThre = 10;                             % Upper threshold


%% Main part

% Read the the nifti file (e.g., sig.nii.gz) 
fsFast = MRIread([mainPath filesep sess filesep 'bold' filesep Analysis filesep conts filesep 'sig.nii.gz']);

% Load the full resolution cortex  model
fullSurf = load([path2bsAnatomy filesep subject filesep 'tess_cortex_pial_high.mat']);

% Apply offset if the vertices belong to the right hemisphere
if strcmp(LoR,'LH')    
    % Find the index of the remaining vertices of the LH after downsampling
    [~, ~, J] = intersect(sSurf.Vertices, fullSurf.Vertices(1:fullSurf.offsetVertices,:), 'rows'); 
    
elseif strcmp(LoR,'RH')
    % Find the index of the remaining vertices of the RH after downsampling
    [~, ~, J] = intersect(sSurf.Vertices, fullSurf.Vertices(fullSurf.offsetVertices+1:end,:), 'rows'); 

end

% Extract the activation of the remaining vertices (from full resolution to
% low resolution)
lowVal = fsFast.vol(J); 

% Sort the values to select the most activated vertices.
[~,I] = sort(lowVal,'descend');

% If the vertices belong to the RH, they should be shifted by the offset
% (number of vertices of the LH) to fall into the RH of the cortex model in
% BrainStorm.
if strcmp(LoR,'RH')
    I = I + sSurf.offsetVertices;
end

% Create scout structure
scout.Vertices = I(1:150)'; % Take the indices of the 150 most activated vertices. 
scout.Seed     = I(1);
scout.Color    = [1 0 0];
scout.Label    = '1';
scout.Function = 'Mean';
scout.Region   = LoR;
scout.Handles = [];

% Import 'scout' to BrainStorm as a new scout