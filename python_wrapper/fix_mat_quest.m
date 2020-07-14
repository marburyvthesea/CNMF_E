addpath(genpath('/projects/p30771/MATLAB/CNMF_E_jjm/')) ;
load('/projects/p30771/MATLAB/CNMF_E_jjm/quest_MATLAB_cnmfe/28-Feb_16_10_05.mat') ; 
neuron = struct(neuron) ;
neuron_out = neuron ;
neuron_out.batches = [] ; 
save('/projects/p30771/MATLAB/CNMF_E_jjm/quest_MATLAB_cnmfe/28-Feb_16_10_05_out.mat','-v6','-struct','neuron_out');