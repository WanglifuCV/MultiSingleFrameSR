%----------------------------------------------------
% Sparse modeling with adaptive sparse domain selection 
% For Image Super-resolution
% Data: Nov. 20, 2010
% Author: Weisheng Dong, Lei Zhang, {wsdong@mail.xidian.edu.cn; cslzhang@comp.polyu.edu.hk}
%----------------------------------------------------
clc;
clear;
addpath(genpath('Codes'));

TestPar.Mode       =    4;   % 1 - 只给高分辨率原图,模拟实验；  
                             % 2 - 只给低分辨图，实际恢复；   
                             % 3 - 给原图和低分辨图；  
                             % 4 - 给原图、低分辨图、和高分辨率初始估计

% Test_image_dir     =    'Data\SR_test_images\Suzie';
Test_image_dir     =    'Data\SR_test_images\Foreman';

if TestPar.Mode == 1
    TestPar.HRimage_name         =    'GroundTruth_0008.tif';                           % input the test image name;
    image_name = TestPar.HRimage_name;
end

if TestPar.Mode == 2
    TestPar.LRimage_name         =    'LowQuality_0008.tif'; 
    image_name = TestPar.LRimage_name;
end

if TestPar.Mode == 3
    TestPar.HRimage_name         =    'GroundTruth_0008.tif'; 
    TestPar.LRimage_name         =    'LowQuality_0008.tif'; 
    image_name = TestPar.HRimage_name;
end

if TestPar.Mode == 4
    TestPar.HRimage_name         =    'GroundTruth_0022.tif'; 
    TestPar.LRimage_name         =    'LowQuality_0022.tif'; 
    TestPar.HRimageEst_name      =    'SR_0022.tif'; 
    image_name = TestPar.HRimage_name;
end
                             
                             
                             


% psf                =     fspecial('gauss', 7, 1.6);              % The simulated PSF
psf                =  fspecial('average',[3,3]);
scale              =    3;                                       % Downsampling factor 3
nSig               =    0;                                       % The standard variance of the additive Gaussian noise;
method             =    2;                                       % 0: ASDS;  1: ASDS_AR;  2: ASDS_AR_NL;
dict               =    1;                                       % 1: dictionary 1 trained from dataset 1; 2: dictionary 2 trained from dataset 2;

if nSig == 0
    Output_dir         =    'Super_resolution\Noiseless_results';    % Where the output image will be generated;
else
    Output_dir         =    'Super_resolution\Noisy_results';        % Where the output image will be generated;
end



% The following codes start to perform the deblurring experiment with the above input parameters;

[im, PSNR, SSIM]   =   Image_Superresolution(method, dict, nSig, psf, scale, Output_dir, Test_image_dir, TestPar);

disp( sprintf('%s: PSNR = %3.2f  SSIM = %f\n', image_name, PSNR, SSIM) ); 
figure; imshow(im./255);
