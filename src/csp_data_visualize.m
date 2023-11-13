% CSP weighted EEG patterns are loaded
csp_pat = load('E:\csp files\CSP_jom_scs_c01_exec_RvsN.mat');
csp_pat = csp_pat.csp_pat;  % Used for loading matrix from structure

% scale the csp for all patterns
for i = 1 : 52 % from first pattern to the last pattern
    csp_range=max(csp_pat(:,i))-min(csp_pat(:,i));
    csp_pat(:,i)=2*(csp_pat(:,i)-min(csp_pat(:,i)))/csp_range-1;    
end

pattern_nb = 42;

update_simpattern=simPattern;
 
% bring the structure of simPattern to matlab and replac the data (F)

update_simpattern.F= repmat(csp_pat(:,pattern_nb),1,501);

% Simulation structure exported to matlab from BrainStorme
update_simpattern.Comment = 'Simulation:  MN: EEG(Full,Constr)_Right_1_csp_42(171129_2231)';



% Take EEG data in one data point
EEG_simulation_pattern = simPattern.F(:,1);
 % scale my signal (mainsimulate)
csp_range=max(EEG_simulation_pattern)-min(EEG_simulation_pattern);
EEG_simulation_pattern=2*(EEG_simulation_pattern-min(EEG_simulation_pattern))/csp_range-1;

update_simpattern.F= repmat(EEG_simulation_pattern,1,501);
update_simpattern.Comment = 'Simulation:  MN: EEG(Full,Constr)_Right_1_scaled(171129_2231)';


