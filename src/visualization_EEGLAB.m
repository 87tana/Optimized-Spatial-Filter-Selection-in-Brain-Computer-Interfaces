% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%% CSP weighted EEG patterns are loaded
% csp_pat = load('E:\csp patterns C1\CSP_jom_scs_c01_exec_RvsN.mat');
% csp_pat = csp_pat.csp_pat;  % Used for loading matrix from structure
% 
% 
% %%%%%%%%%%%%%%%%%%%% Sscale all CSP patterns between 1 and -1 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% for i = 1 : 52 % from first pattern to the last pattern
%     csp_range=max(csp_pat(:,i))-min(csp_pat(:,i));
%     csp_pat(:,i)=2*(csp_pat(:,i)-min(csp_pat(:,i)))/csp_range-1;    
% end

% The csps should be read using the csp_correlation script and the negative
% correlations become mirror before visualization.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Plot all csp patterns using EEGlab

figure;
for k = 1 : 52
    subplot(7,8,k);
    topoplot(modified_csp_pat(:,k),EEG.chanlocs);
    title(num2str(k));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% To adjust the main simulation's data (make it scaled)

% Take EEG data in one data point
update_simpattern = simPattern;
scaled_sim = simPattern.F(:,1);
 % scale my signal (mainsimulate)
simulation_range=max(scaled_sim)-min(scaled_sim);
scaled_sim =2*(scaled_sim-min(scaled_sim))/simulation_range-1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% plot the topoplot of the simulated pattern

figure;
topoplot(scaled_sim,EEG.chanlocs);