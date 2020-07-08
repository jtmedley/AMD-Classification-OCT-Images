%Region analysis and results

%Truth data for classification
classification = [zeros(length(amdcurves), 1); ones(length(controlcurves), 1)];

%Combined region properties for boxplots
area = [areasamd areascontrol];
hullarea = [hullareasamd hullareascontrol];
perimeter = [perimetersamd perimeterscontrol];
majoraxislength = [majoraxislengthsamd majoraxislengthscontrol];
minoraxislength = [minoraxislengthsamd minoraxislengthscontrol];
areaoverperimeter = [areaoverperimetersamd areaoverperimeterscontrol];
areaovermajoraxis = [areaovermajoraxisamd areaovermajoraxiscontrol];

%Boxplots
boxplot(area, classification);
title('Area');
figure;
boxplot(hullarea,classification,'Labels',{'AMD','Control'});
title('Hull Area');
figure;
boxplot(perimeter,classification,'Labels',{'AMD','Control'});
title('Perimeter');
figure;
boxplot(areaoverperimeter,classification,'Labels',{'AMD','Control'});
title('Area / Perimeter');
figure;
boxplot(areaovermajoraxis,classification,'Labels',{'AMD','Control'});
title('Area / Major Axis Length');