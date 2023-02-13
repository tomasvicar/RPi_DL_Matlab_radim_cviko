clear all, close all; clc;

r = raspi();

board = targetHardware('Raspberry Pi');

board.CoderConfig.TargetLang = 'C++';


dlcfg = coder.DeepLearningConfig('arm-compute');
dlcfg.ArmArchitecture = 'armv7';

% r.system('strings $ARM_COMPUTELIB/lib/libarm_compute.so | grep arm_compute_versio | cut -d\  -f 1')
dlcfg.ArmComputeVersion = '20.02.1';
board.CoderConfig.DeepLearningConfig = dlcfg;
deploy(board,'raspi_webcam_mynet')


clear r;