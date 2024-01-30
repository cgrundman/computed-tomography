 %% Hip Mask 
 % load the hip sinogram
 data=load('hip_sino.mat');
 sino=data.sino;
 % perform the reconstruction
 reco=reconstruct(sino);
    
 % visualize the reconstructed image
 level=0.014;
 window=0.007;
 vmin=level-window/2;
 vmax=level+window/2;
 figure(); 
 imshow(reco, [vmin vmax]); 
 axis image
 colormap gray(256)

 img = imadjust(reco);  % contrasting
 bw = edge(reco,"canny",0.02,2); % edge detection with Canny method
 bw = imfill(bw,'holes'); % fill closed areas on the image
 %  figure();
 %  imshow(bw);
 se = strel('disk',1); % form a structural element
 bw = imopen(bw,se);  % morphological opening, lines disappear 
 figure();
 imshow(bw);
 fp_mask = forwardproject(bw); % forwardproject the mask
 % this is our mask
 figure();
 imshow(fp_mask);
