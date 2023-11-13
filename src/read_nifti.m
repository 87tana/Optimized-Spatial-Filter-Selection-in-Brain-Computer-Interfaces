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
Analysis = 'my_handexecution.sm05.lh';  % Analysis
conts = 'right-v-left';                 % Contrast
LoR = 'LH';                             % LH or RH
LowThre = 2;                            % Low threshold 
UpThre = 10;                             % Upper threshold


%% Main part

% Read the the nifti file (e.g., sig.nii.gz) 
fsFast = MRIread([mainPath filesep sess filesep 'bold' filesep Analysis filesep conts filesep 'sig.nii.gz']);

% Load the full resolution cortex  model
fullSurf = load([path2bsAnatomy filesep subject filesep 'tess_cortex_pial_high.mat']);

% Threshold the activation
threActiv = find(fsFast.vol>LowThre & fsFast.vol<UpThre);

% Apply offset if the vertices belong to the right hemisphere
% offsetVertices is the number of vertives of the left hemisphere.
% BrainStorm considers the whole cortex but FreeSurfer consider each
% hemisphere seperately, therefore their indexing is a bit different. We
% need to shift the vertices of the left hemishphere with the values of
% offset to fall into the right hemisphere of the cortex in BrainStorm.
% In order to have offsetVertices, we need to modify the functions in
% BrainStorm.
if strcmp(LoR,'RH')
    threActiv = threActiv + fullSurf.offsetVertices;
end

% Extract the coordinates of the label points from the surface.
% tmpVert=selected vertices of full resolution
tmpVert = fullSurf.Vertices(threActiv,:);

% Find the corresponding vertices to the label vertices in
% the lower resolution surface.
% sSurf= low resolution ~10k
% I =  indices of those selected vertices in temVert that still exist in sSurf
[~, I, ~] = intersect(sSurf.Vertices, tmpVert, 'rows');      

% Create scout structure
% Export a sample scout from brainstorm to matlab and used it as a template
% to create the scout.
scout.Vertices = I';
scout.Seed     = I(1);
scout.Color    = [1 0 0];
scout.Label    = '1';
scout.Function = 'Mean';
scout.Region   = LoR;
scout.Handles = [];

% Import 'scout' to BrainStorm as a new scout