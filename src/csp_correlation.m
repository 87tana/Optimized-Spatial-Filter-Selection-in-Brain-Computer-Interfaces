% CSP weighted EEG patterns are loaded
csp_pat = load('E:\csp files\CSP_jom_scs_c01_exec_RvsN.mat');
csp_pat = csp_pat.csp_pat;  % Used for loading matrix from structure

% Take EEG data in one data point
EEG_simulation_pattern = simPattern.F(:,1);
 % scale my signal (mainsimulate)
csp_range=max(EEG_simulation_pattern)-min(EEG_simulation_pattern);
EEG_simulation_pattern=2*(EEG_simulation_pattern-min(EEG_simulation_pattern))/csp_range-1;

% scale the csp for all patterns
for i = 1 : 52 % from first pattern to the last pattern
    csp_range=max(csp_pat(:,i))-min(csp_pat(:,i));
    csp_pat(:,i)=2*(csp_pat(:,i)-min(csp_pat(:,i)))/csp_range-1;    
end


corr_vect = zeros(1,52);
for i = 1 : 52 % from first pattern to the last pattern
    R = corrcoef(csp_pat(:,i),EEG_simulation_pattern); % correlation between EEG volatge distribution and each pattern
    corr_vect(i) = abs(R(2,1)); 
end


% plot the coefficients
figure; 
bar(corr_vect)

% plot the most similar signal
figure;
plot(EEG_simulation_pattern);
hold on
plot(csp_pat(:,41));


