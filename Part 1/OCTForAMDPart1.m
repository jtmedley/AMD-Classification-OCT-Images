%Classification of AMD from OCT Images - Part 2
%Jonathan Medley
%Biomedical Signal Analysis
%Prof. Matthew Kay

close all;
clear;
clc;
%Run once
%run ImageImporting.m;

%Run after running ImageImporting.m once
load allimages.mat;

%Run always
run AMDProcessing.m;
run ControlProcessing.m;
run BiomarkerAssignment.m;
run RegionAnalysis.m;