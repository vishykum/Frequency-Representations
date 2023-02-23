%Frequency representations
lf = imread("LP.png");
hf = imread("HP.png");

low_fou = fftshift(abs(fft2(lf)));
high_fou = fftshift(abs(fft2(hf)));

imshow([low_fou high_fou] / 35000);


%Visualize kernels
sobel = [-1 0 1;-2 0 2;-1 0 1];
gaus = fspecial('gaussian', 15, 2.5);
dog = conv2(gaus, sobel);

surf(gaus);
title("gaus");
figure;
surf(dog);
title("DoG");

hp_gaus = imfilter(hf, gaus);
imshow(hp_gaus);
hp_gaus_fou = fftshift(abs(fft2(hp_gaus)));

imshow([high_fou hp_gaus_fou] / 35000);

lp_gaus = imfilter(lf, gaus);
imshow(lp_gaus);
lp_gaus_fou = fftshift(abs(fft2(lp_gaus)));

imshow([low_fou lp_gaus_fou] / 35000);

% g = fft2(gaus, 500, 500);
% dog_fou = fft2(dog, 500, 500);
% lp_fou = fft2(lf);
% hp_fou = fft2(hf);
% lp_dog_fou = g .* lp_fou;
% hp_dog_fou = hp_fou .* g;
% imshow([fftshift(abs(hp_dog_fou)), fftshift(abs(lp_dog_fou))]);
% figure;
% filt_hf = ifft2(hp_dog_fou);
% imshow(filt_hf);



%Anti-aliasing
hp_sub2 = hf(1:2:end, 1:2:end);
lp_sub2 = lf(1:2:end, 1:2:end);

imshow([hp_sub2 lp_sub2]);

hp_sub2_freq = fftshift(abs(fft2(hp_sub2)));
lp_sub2_freq = fftshift(abs(fft2(lp_sub2)));

imshow([fftshift(abs(fft2(hp_sub2, 500, 500))) high_fou] / 35000);
figure;
imshow([fftshift(abs(fft2(lp_sub2, 500, 500))) low_fou] / 35000);

hp_sub4 = hf(1:4:end, 1:4:end);
lp_sub4 = lf(1:4:end, 1:4:end);

imshow([hp_sub4 lp_sub4]);

hp_sub4_freq = fftshift(abs(fft2(hp_sub4)));
lp_sub4_freq = fftshift(abs(fft2(lp_sub4)));

imshow([fftshift(abs(fft2(hp_sub4, 500, 500))) high_fou] / 40000);
figure;
imshow([fftshift(abs(fft2(lp_sub4, 500, 500))) low_fou] / 40000);

gauss_alias = fspecial('gaussian', 10, 0.3);
surf(gauss_alias);
figure;
hp_anti_alias = imfilter(hp_sub2, gauss_alias);
hp_fre_anti_alias = fftshift(abs(fft2(hp_anti_alias)));
imshow([hp_sub2 hp_anti_alias]);
figure;

lp_anti_alias = imfilter(lp_sub2, gauss_alias);
lp_fre_anti_alias = fftshift(abs(fft2(lp_anti_alias)));
imshow([lp_sub2 lp_anti_alias]);

figure;
imshow([hp_sub2_freq hp_fre_anti_alias] / 35000);

figure;
imshow([lp_sub2_freq lp_fre_anti_alias] / 35000);

gauss_alias_2 = fspecial('gaussian', 10, 0.02);
surf(gauss_alias_2);
figure;
hp_anti_alias_2 = imfilter(hp_sub4, gauss_alias_2);
hp_fre_anti_alias_2 = fftshift(abs(fft2(hp_anti_alias_2)));

imshow([hp_sub4 hp_anti_alias_2]);
figure;
imshow([hp_sub4_freq hp_fre_anti_alias_2] / 35000);

%Canny Edge detection
[cannyedge, thresh] = edge(hf, 'canny', []);
thresh_opt = thresh;
thresh_opt(1) = 0.17;
thresh_opt(2) = 0.22;
imshow(edge(hf, 'canny', thresh_opt));
title("optimal hf");
figure;

thresh_mod = thresh_opt;
thresh_mod(1) = 0.01;
imshow(edge(hf, 'canny', thresh_mod));
title("low-low hf");
figure;

thresh_mod = thresh_opt;
thresh_mod(1) = 0.20;
imshow(edge(hf, 'canny', thresh_mod));
title("high-low hf");
figure;

thresh_mod = thresh_opt;
thresh_mod(2) = 0.172;
imshow(edge(hf, 'canny', thresh_mod));
title("low-high hf");
figure;

thresh_mod = thresh_opt;
thresh_mod(2) = 0.5;
imshow(edge(hf, 'canny', thresh_mod));
title("high-high hf");

[cannyedge, thresh] = edge(lf, 'canny', []);
thresh_opt = thresh;
imshow(edge(lf, 'canny', thresh_opt));
title("optimal hf");
figure;

thresh_mod = thresh;
thresh_mod(1) = 0.002;
imshow(edge(lf, 'canny', thresh_mod));
title("low-low hf");
figure;
edge(lf, 'canny', thresh_opt)
thresh_mod = thresh;
thresh_mod(1) = 0.03;
imshow(edge(lf, 'canny', thresh_mod));
title("high-low hf");
figure;

thresh_mod = thresh;
thresh_mod(2) = 0.027;
imshow(edge(lf, 'canny', thresh_mod));
title("low-high hf");
figure;

thresh_mod = thresh;
thresh_mod(2) = 0.05;
imshow(edge(lf, 'canny', thresh_mod));
title("high-high hf");