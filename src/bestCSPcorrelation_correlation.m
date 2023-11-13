
addpath('/home/tannaz/matlab code');
addpath('/home/tannaz/matlab code/draw_confusion_matrix');
% 
% % Subject IDs (ordered based on the subject IDs)
% SUBJID = {'c01';
% %           'c02';
%           'c04';
%           'c05';
%           'c06';
%           'c08';
%           'c09';
%           'c11';
%           'c13';
%           'c14';
%           'c15';
%           'c16';
%           'c17';
% %           'c18';
% %           'c20';
%           'c21';
%           'c22';
%           'c23';
%           'c24';
%           'c25';
%           'c26';
%           'Avg.'};
%       
%       
      
% Subject IDs (ordered based on the HKnob LHem)
SUBJID = {'c01';
          'c04';
          'c05';
          'c06';
          'c14';
          'c15';
          'c17';
          'c21';
          'c22';
          'c24';
          'c26';
          'c08';
          'c09';
          'c11';
          'c13';
          'c16';
          'c25';
          'c23';
          'Avg.'};


% % Subject IDs (ordered based on the HKnob RHem)
% SUBJID = {'c04';
%           'c05';
%           'c06';
%           'c08';
%           'c09';
%           'c11';
%           'c14';
%           'c15';
%           'c21';
%           'c22';
%           'c23';
%           'c24';
%           'c25';
%           'c26';
%           'c01';
%           'c13';
%           'c17';
%           'c16';
%           'Avg.'};
% 
% 
% Left or Right Hem
LoR = 'LHem_RHand';

% Based on best Correlation or best Quality score. (BCorr / BQS)
CoQ = 'BCorr';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main path to the csp-simPattern correlations
info_path = '/home/tannaz/data/evaluation_outputs/mat.files/';

% Main path to the CSPs.
csp_path = '/home/tannaz/data/CSP/CSP_mod_name';

% Matrix to store the simPatterns
CSP_mat = zeros(96,numel(SUBJID));

% Loop to read the simPatterns of all subjects
for iInd = 1 : numel(SUBJID)-1
    
    % Read the info about the statistics
    info = load([info_path filesep SUBJID{iInd} '_' LoR '_info.mat']);
    
    if strcmp(CoQ,'BCorr')
        % Correlation of the CSPs to the simPattern
        corr_vect = info.inf.corr_vect;
        % Index to the best correlation
        [~,bestIndex] = max(abs(corr_vect));
        
    elseif strcmp(CoQ,'BQS')
        % Quality score of the CSPs.
        corr_ERD_Prod = info.inf.corr_ERD_Prod;
        % Index to the best Quality score 
        [~,bestIndex] = max(corr_ERD_Prod);     
        
    end        
    
    % Read CSPs
    CSPs = load([csp_path filesep 'CSP_jom_scs_' SUBJID{iInd} '_all_csp.mat']);
    CSPs = CSPs.csp_pat;    
    
    % Put the best correlated CSP to the CSP matrix.
    CSP_mat(:,iInd) = CSPs(:,bestIndex);
    
end

% Compute the average cspPattern
CSP_mat(:,end) = sum(CSP_mat,2)/(numel(SUBJID)-1);

% Matrix to store the correlation between the best CSPs (i.e., based correlated CSPs)
CSP_Corr_mat = zeros(numel(SUBJID));

for iInd = 1 : numel(SUBJID)
    for jInd = iInd + 1 : numel(SUBJID)
        
        R = corrcoef(CSP_mat(:,iInd),CSP_mat(:,jInd)); 
        CSP_Corr_mat(iInd,jInd) = R(2,1);       
        
    end
end

% Fill in the mirrored part of the matrix
CSP_Corr_mat = CSP_Corr_mat + CSP_Corr_mat';

% Fill in the diagonal with 1
CSP_Corr_mat = CSP_Corr_mat + eye(numel(SUBJID));
% 
% % Plot the correlation matrix with numbers
%  draw_cm(simPatternCorr_mat,SUBJID,numel(SUBJID));
 
% Plot the correlation matrix without numbers
figure;
axis ([1 8 1 8]);
imagesc(CSP_Corr_mat); 
colormap(jet)
set(gca, 'fontsize',10);
set(gca,'xtick', 1:numel(SUBJID),'xticklabel',SUBJID);
set(gca,'ytick', 1:numel(SUBJID),'yticklabel',SUBJID);
xtickangle(315);
colorbar;
caxis([0,1]);

%title('CSPs Corr with best Qual. Score, axes ordered based on LHem HKnob','FontSize',9);
 title('CSPs Corr with best corr. Score, axes ordered based on LHem HKnob','FontSize',9);
