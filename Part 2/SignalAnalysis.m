%Analysis of extracted signals
meanpowers = [];
for i=1:size(signal,1)
    %Select signal for filtering
    currentsignal = signal(i,:);
    %Plot current signal
    figure;
    plot(currentsignal);
    title('RPEDC Upper Boundary');
    xlabel('Horizontal Distance (Pixels)');
    ylabel('RPEDC Upper Boundary Position (Pixels)');
    currentsignal = currentsignal - mean(currentsignal);
    
    %Calculate and plot autocovariance
    Rdata = xcov(currentsignal,'biased');
    figure;
    plot(Rdata);
    title('Autocovariance of Upper Boundary Location');
    xlabel('Distance (pixels)');
    ylabel('Autocovariance');
    
    %Differentiation filter
    currentsignal = diff(currentsignal);
    
    %Median filter
    currentsignal = medfilt1(currentsignal);
    
    %Removal of the mean
    currentsignal = currentsignal - mean(currentsignal);
    
    %Power spectral density determination and plot
    samplefrequency = 0.1;
    [Pdata,freq] = pwelch(currentsignal,[],[],[],samplefrequency);
    figure;
    plot(freq,Pdata);
    title('Power Spectrum');
    xlabel('Frequency (1/Pixel)');
    ylabel('Power');
    
    %Average power spectral density calculation
    meanpowers(i) = mean(Pdata);
end

%Re-separation of AMD and control data
amdpower = meanpowers(1:5);
controlpower = meanpowers(6:10);
%Rearranging for boxplot
powers = [amdpower', controlpower'];

%Plot average power spectral density
figure;
boxplot(powers,'Labels',{'AMD','Control'});
title('Average Power in AMD vs Control RPEDC Upper Boundary');

%FIFO figure ordering
orderFigures;