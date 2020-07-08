%Biomarker Assignment:
close all;
clearvars -except allimages controlimages amdtrain amdtest controltrain controltest amdcurves controlcurves;

%Assign biomarker variables from isolated AMD image region properties
for a=1:length(amdcurves)
    areasamd(a) = amdcurves(a).Area;
    hullareasamd(a) = amdcurves(a).ConvexArea;
    perimetersamd(a) = amdcurves(a).Perimeter;
    majoraxislengthsamd(a) = amdcurves(a).MajorAxisLength;
    minoraxislengthsamd(a) = amdcurves(a).MinorAxisLength;
    areaoverperimetersamd = areasamd./perimetersamd;
    areaovermajoraxisamd = areasamd./majoraxislengthsamd;
end

%Assign biomarker from isolated control image region properties
for a=1:length(controlcurves)
    areascontrol(a) = controlcurves(a).Area;
    hullareascontrol(a) = controlcurves(a).ConvexArea;
    perimeterscontrol(a) = controlcurves(a).Perimeter;
    majoraxislengthscontrol(a) = controlcurves(a).MajorAxisLength;
    minoraxislengthscontrol(a) = controlcurves(a).MinorAxisLength;
    areaoverperimeterscontrol = areascontrol./perimeterscontrol;
    areaovermajoraxiscontrol = areascontrol./majoraxislengthscontrol;
end