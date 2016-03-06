addpath('MILL');
addpath('reducedData');

MIL_Run('classify -t base.data -sf 1 –n 0 -- iterdiscrim_APR');
% MIL_Run('classify -t example.data -sf 1 -n 1 -- cross_validate -t 5 -- DD -NumRuns 10 -Aggregate avg');
