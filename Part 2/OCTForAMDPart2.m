%Classification of AMD from OCT Images - Part 1
%Jonathan Medley
%Cell and Molecular Imaging, Biomedical Signal Analysis
%Prof. Emilia Entcheva, Prof. Mattthew Kay

close all;
clear;
clc;
%Run once
%run ImageImporting.m;

%Run after running ImageImporting.m once
load allimages.mat;

%Run always
run SignalExtraction.m
run SignalAnalysis.m
run ROCAnalysis.m