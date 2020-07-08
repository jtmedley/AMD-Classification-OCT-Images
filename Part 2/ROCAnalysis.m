%Receiver Operating Characteristic calculation
%Rearrange average power spectral density dataset for ROC
rocset=[powers(:,1);powers(:,2)];
rocset=rocset';

%Classify each index of dataset as positive or negative from truth data
classification = [1 1 1 1 1 -1 -1 -1 -1 -1];

%Calculate ROC performance curve and optimal thresholds
[x1,y1,thresholdtable,auc1,opt] = perfcurve(classification,rocset,1);
threshold = thresholdtable(find(x1 == opt(1) & y1 == opt(2)));
plot(x1,y1,'LineWidth',3);
title('ROC');
xlabel('False Positive Rate (1-Specificity)');
ylabel('True Positive Rate (Sensitivity)');

%Print classification threshold
disp(threshold);