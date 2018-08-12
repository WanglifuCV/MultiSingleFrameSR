%----------------------------------------------------
% Sparse modeling with adaptive sparse domain selection 
% For Image Deblurring
% Data: Nov. 20, 2010
% Author: Weisheng Dong, Lei Zhang, {wsdong@mail.xidian.edu.cn; cslzhang@comp.polyu.edu.hk}
%----------------------------------------------------
clc;
clear;
addpath('Codes\PCA_functions');
addpath('Codes\Utilities');

Testpar.Mode  =  3;  % 1 - 输入未降质原图  % 2 - 输入模糊图像   % 3 - 输入降质图像和原图

Test_image_dir     =    'Data\Deblurring_test_images';

blur_type          =    1;          % 1: uniform blur kernel;  2: Gaussian blur kernel; 

if blur_type == 1                   % When blur_type = 1, blur_par denotes the kernel size; When blur_type = 2, blur_par denotes the standard variance of Gaussian kernel
    blur_par       =    3;          % the default blur kernel size is 9 for uniform blur;
    Output_dir         =    'Deblurring\Uniform_blur';
else
    blur_par       =    3;          % the default standard deviation of Gaussian blur kernel is 3
    Output_dir         =    'Deblurring\Gaussian_blur'; 
end

nSig               =    sqrt(45);    % The standard variance of the additive Gaussian noise;
method             =    2;          % 0: ASDS;  1: ASDS_AR;  2: ASDS_AR_NL;
dict               =    2;          % 1: dictionary 1 trained from dataset 1; 2: dictionary 2 trained from dataset 2;

if Testpar.Mode == 1
    Testpar.Orgimage_name         =    'GroundTruth_0008.tif';    % input the test image name;
    image_name                    =   Testpar.Orgimage_name;
end

if Testpar.Mode == 2
    Testpar.Blurimage_name        =    'GroundTruth_0008.tif';    % input the test image name;
    image_name                    =    Testpar.Blurimage_name;
end

if Testpar.Mode == 3
    Testpar.Orgimage_name         =    'GroundTruth_0022.tif';    % input the test image name;
    Testpar.Blurimage_name        =    'SR_0022.tif';
    image_name                    =   Testpar.Orgimage_name;
end

% The following codes start to perform the deblurring experiment with the above input parameters;

[im PSNR SSIM]   =   Image_Deblurring(method, dict, nSig, Output_dir, Test_image_dir, image_name, blur_type, blur_par, Testpar);

disp( sprintf('%s: PSNR = %3.2f  SSIM = %f\n', image_name, PSNR, SSIM) ); 

 figure; imshow(im./255);