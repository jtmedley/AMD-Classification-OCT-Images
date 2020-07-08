close all;
clc;
clearvars -except amdimages controlimages amdtrain amdtest controltrain controltest amdcurves;%Control image processing:
%Control image processing:
%Number of sample images
controlimagecount = 4;
%Structuring elements for morphological operations
controldisk1 = strel('disk',1);
controldisk2 = strel('disk',2);
controlrect3 = strel('rect',[3 6]);

%Process selected images from training dataset
for i=1:controlimagecount
    %Original image
    prefiltimage = controltrain(:,:,i);
    figure;
    colormap(gray);
    imagesc(prefiltimage);

    %Windowing filter    
    prefiltimage=imadjust(prefiltimage,[.2 1]);
    
    %Weiner adaptive noise removal filter
    prefiltimage=wiener2(prefiltimage,[5 5]);
    
    %Prefiltered image
    figure;
    colormap(gray);
    imagesc(prefiltimage);

    %Image binarization
    binarizedimage = imbinarize(prefiltimage,'adaptive');
    
	%Image area opening
    binarizedimage = bwareaopen(binarizedimage,5000);
    figure;
    colormap(gray);
    imagesc(binarizedimage)
    
    %Image morphological opening and repeat area opening
    binarizedimage = imopen(binarizedimage,controldisk1);
    binarizedimage = bwareaopen(binarizedimage,1000);

    %Filling binary holes and image closing
    binarizedimage = imfill(binarizedimage,'holes');
    binarizedimage = imclose(binarizedimage,controldisk2);
    binarizedimage = bwareaopen(binarizedimage,2000);
    binarizedimage = imfill(binarizedimage,'holes');
    binarizedimage = imclose(binarizedimage,controlrect3);
    processedimage = imfill(binarizedimage,'holes');
    
    %Processed image    
    figure;
    colormap(gray);
    imagesc(processedimage)
    
    %Image with labeled region
    [labeledimage,labelnumber] = bwlabeln(processedimage);
    
    %Colormapped region-labeled image
    rgblabeledimage = label2rgb(labeledimage);
    figure;
    imshow(rgblabeledimage);
    
    %Extract image region properties
    regiondata = regionprops(labeledimage,'all');
    centroidy = [];
    centroidx = [];
    for j=1:length(regiondata)
        centroid = regiondata(j).Centroid;
        centroidx(j) = centroid(1);
        centroidy(j) = centroid(2);
        centroidx2=centroidx-500;
        centroidy2 = centroidy-256;
        distance = (centroidx2.^2+centroidy2.^2).^.5;
    end
    
    %Find minimum distance from origin
    mindistanceindex = find(abs(distance) == min(abs(distance)));
    hold on
    hull = regiondata(mindistanceindex).ConvexHull;
    plot(hull(:,1),hull(:,2),'r')
    
    %Store properties of isolated regions
    controlcurves(i) = regiondata(mindistanceindex);
end