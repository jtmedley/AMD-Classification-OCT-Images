%AMD image processing: revised from Part 1

%Morphological structuring element - disk of size 2
disk = strel('disk',2);

%Preallocation
signal = [];
selected = [];
%Sample selected images from 5 AMD images and 5 control images - need more
selected(:,:,1:5) = amdtrain(:,:,[7,9,14,17,18]);
selected(:,:,6:10) = controltrain(:,:,[10,15,16,17,20]);

%Iterate analysis for all selected images
for i=1:10
    %Original prefiltered image
    I = selected(:,:,i);
    figure;
    colormap(gray);
    imagesc(I);
    title('Original');
    
    %Toggle weiner filter and initial imopen if desired
    %I=wiener2(I,[5 5]);
    %I = imopen(I,s1);
    
%     figure;
%     colormap(gray);
%     imagesc(I);
%     title('After Closing');

    %Toggle median filter if desired
%     I = medfilt2(I);
%     figure;
%     colormap(gray);
%     imagesc(I);
%     title('After Median');

    %Thresholding filter
    I=imadjust(I,[.5 1]);
    figure;
    colormap(gray);
    imagesc(I);
    title('After Thresholding');
    
    %Triple hole filling - solidify regions
    I = imfill(I);
    I = imfill(I);
    I = imfill(I);
    
    %Image after hole filling
    figure;
    colormap(gray);
    imagesc(I);
    title('After Fill Holes');
    
    %Weiner adaptive noise removal filter
    I = wiener2(I,[15 15]);
    figure;
    colormap(gray);
    imagesc(I);
    title('After Weiner');
    
    %Final binary hole filling
    I = imfill(I,'holes');
    
    %Image binarization
    binarized = imbinarize(I);
    
    %Image after binarization
    figure;
    colormap(gray);
    imagesc(binarized);  
    title('After Binarization');
    
    %Area open binary morphological operation
    binarized = bwareaopen(binarized,5000);
    
    %Image closing operation using s1 disk
    binarized = imclose(binarized,disk);
    
    %Image after post-binarization processing
    figure;
    colormap(gray);
    imagesc(binarized);
    title('After Area Open and Close');
    
    %Final processed image
    finalimage = binarized;
    
    %Labeled image regions
    [labeledimage,labelnumber] = bwlabeln(finalimage);
    
    %Colormapped labeled image regions
    rgblabeledimage = label2rgb(labeledimage);
    figure;
    imshow(rgblabeledimage);
    
    %Final image region properties
    regionproperties = regionprops(labeledimage,'all');
    
    %Region centroids and distance calculators
    centroidy = [];
    centroidx = [];
    for j=1:length(regionproperties)
        centroid = regionproperties(j).Centroid;
        centroidx(j) = centroid(1);
        centroidy(j) = centroid(2);
        centroidx2=centroidx-500;
        centroidy2 = centroidy-256;
        distance = (centroidx2.^2+centroidy2.^2).^.5;
    end
    
    %Index location of region with minimum distance from origin
    targetindex = find(abs(distance)==min(abs(distance)));
    %Remove regions not selected
    labeledimage(~targetindex)=0;
    
    %Region of interest
    figure;
    colormap(gray);
    imagesc(labeledimage);  
    title('Isolated Region');
    [peak,peaklocation] = max(finalimage);
    signal(i,:) = peaklocation;
end
%Reorder figures so they appear in FIFO rather than LIFO order
orderFigures;