function phantom_smooth(vmin, vmax)
% INPUTS
% vmin - minimum display window
% vmax - maximum display window
% 
% OUTPUTS

disp("Running: phantom_smooth.m")

%% Original Data and Mask
% Load Data
phantom_data = load('phantom_sino.mat');
phantom_sino = phantom_data.sino;
% Load Mask
mask = load('phantom_mask.mat');
mask_sino_logical = mask.mask_sino_logical;

%% Smoothing
% Invert mask
mask_sino_invert = ~mask_sino_logical;

% Original sinogram without metal data
phantom_sino_invert = phantom_sino.*mask_sino_invert;

% List the Smoothing techniques used
smooth_type = ["movmean", "movmedian", "gaussian", "lowess"];

% Initialize Variables
phantom_smoothing = zeros(size(phantom_sino,1),size(phantom_sino,2),1);
phantom_sino_masked = phantom_smoothing;
phantom_sinogram    = phantom_smoothing;
reconstruction      = zeros(520,520,1);

% Iteration through types of filtering
for i=1:length(smooth_type)

    % Smooth with current smoothing type
    phantom_smoothing(:,:,i) = smoothdata(phantom_sino,smooth_type(i));
    
    % Find intersection of mask and smooth data
    phantom_sino_masked(:,:,i) = phantom_smoothing(:,:,i).*mask_sino_logical;
    
    % Combine smoothed data and orginial data
    phantom_sinogram(:,:,i) = phantom_sino_invert + phantom_sino_masked(:,:,i);
    
    % Reconstruct the image
    reconstruction(:,:,i) = reconstruct(phantom_sinogram(:,:,i));
end

% Create Hybrid Smoothing Type
% Smooth with current smoothing type
phantom_smoothing(:,:,5) = (phantom_smoothing(:,:,1) + phantom_smoothing(:,:,2))/2; % Combine Gaussian with Average
% Find intersection of mask and smooth data
phantom_sino_masked(:,:,5) = phantom_smoothing(:,:,5).*mask_sino_logical;
% Combine smoothed data and orginial data
phantom_sinogram(:,:,5) = phantom_sino_invert + phantom_sino_masked(:,:,5);
% Reconstruct the image
reconstruction(:,:,5) = reconstruct(phantom_sinogram(:,:,5));

% Visualize the sinograms and reconstructions
fig_1 = figure('units','normalized','outerposition',[0 0 1 .75]);

titles = ["Average"; 
          "Median";
          "Gaussian"; 
          "Linear";
          "Combined"];

for i=1:size(reconstruction,3)

    subplot(2,5,i)
    imagesc(phantom_sinogram(:,:,i), [0 7])
    colormap gray(256)
    title(titles(i),'FontSize',36)
    axis('square')
    if i==1
        ylabel("Sinogram",'FontSize',30)
    end
    xticklabels ''
    yticklabels ''

    subplot(2,5,i+5)
    imagesc(reconstruction(:,:,i), [vmin vmax]);
    colormap gray(256)
    axis('square')
    if i==1
        ylabel("Reconstruction",'FontSize',30)
    end
    xticklabels ''
    yticklabels ''

end

saveas(fig_1,'figures/phantom_smoothing_results.jpg');

end
