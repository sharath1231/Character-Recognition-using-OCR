%%%%%%  Simulate blur effect   %%%%%%%


%%%% This file creates a blurred image and then de-blurs it using weiner
%%%% filter

%%%% The output of this file is later used in the OCR program to test the
%%%% working of a deblurred image


I = im2double(imread('photo op\2.jpg'));
imshow(I);
title('Original Image (courtesy of MIT)');
LEN = 21;
THETA = 11;
PSF = fspecial('motion', LEN, THETA);
blurred = imfilter(I, PSF, 'conv', 'circular');
figure, imshow(blurred)
noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(blurred, 'gaussian', ...
                        noise_mean, noise_var);
figure, imshow(blurred_noisy)
title('Simulate Blur and Noise');
estimated_nsr = 0;
wnr2 = deconvwnr(blurred_noisy, PSF, estimated_nsr);
% figure, imshow(wnr2)
% title('Restoration of Blurred, Noisy Image Using NSR = 0');
estimated_nsr = noise_var / var(I(:));
wnr3 = deconvwnr(blurred_noisy, PSF, estimated_nsr);
figure, imshow(wnr3)
title('Restoration of Blurred, Noisy Image Using Estimated NSR');