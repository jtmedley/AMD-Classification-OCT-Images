%Loading Control Images
%Time consuming - only do once, then load saved results from allimages.mat

%Selected 2D slice of 3D OCT images
slice=50;

%String for file opening
matstring = '.mat';

%Loading control images
controlstring = 'Control\Farsiu_Ophthalmology_2013_Control_Subject_1';
controlimages = [];

%Concatenate appropriate file string and read in image
for i=1:115
    numstring = num2str(i);
    if i<10
        numstring = strcat('0',numstring);
    end
    if i<100
        numstring = strcat('0',numstring);
    end
    filestring = strcat(controlstring,numstring);
    filestring = strcat(filestring,matstring);
    load(filestring);

    controlimages(:,:,i) = images(:,:,slice);
end

%Loading AMD Images
amdstring = 'AMD\Farsiu_Ophthalmology_2013_AMD_Subject_1';
amdimages = [];

%Concatenate appropriate file string and read in image
for i=1:269
    numstring = num2str(i);
    if i<10
        numstring = strcat('0',numstring);
    end
    if i<100
        numstring = strcat('0',numstring);
    end
    filestring = strcat(amdstring,numstring);
    filestring = strcat(filestring,matstring);
    load(filestring);
    amdimages(:,:,i) = images(:,:,slice);
end

%Separation of the dataset and conversion to percentages
amdimages = amdimages./255;
amdtrain = amdimages(:,:,1:188);
amdtest = amdimages(:,:,189:end);
controlimages = controlimages./255;
controltrain = controlimages(:,:,1:80);
controltest = controlimages(:,:,81:end);

%Saving workspace variables for later use
save('allimages.mat','amdimages','amdtest','amdtrain','controlimages','controltest','controltrain');