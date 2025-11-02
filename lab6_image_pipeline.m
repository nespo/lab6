
%% Lab 6: Mini Project – Your Image Pipeline
% Course: Mathematical Algorithms (DSP) — Image Processing Labs
% Author: (Your Name)
% Date: 2025-11-02
% -------------------------------------------------------------------------
% Pipeline stages:
% 1) Load -> 2) Denoise (median) -> 3) Enhance (contrast) ->
% 4) Edges (Canny) -> 5) Frequency-domain LP -> 6) Visualize + Save
% -------------------------------------------------------------------------
close all; clear; clc;

%% 1) Load your own image (object, face, landscape, etc.)
% Replace 'your_image.jpg' with your own file if desired.
fname = 'your_image.jpg';
if ~exist(fname, 'file')
    error('Image file not found: %s. Put your image in this folder.', fname);
end
I_rgb = imread(fname);
if size(I_rgb,3) == 3
    I = rgb2gray(I_rgb);
else
    I = I_rgb;
end
I = im2double(I);

%% 2) Pre-process: noise removal (median filter)
I_filt = medfilt2(I, [3 3]);

%% 3) Enhance contrast (contrast stretching)
I_enh = imadjust(I_filt, [0.2 0.8], [0 1]);

%% 4) Extract features (edges via Canny)
% thresholds tuned for mid-contrast images; adjust if needed
edges = edge(I_enh, 'Canny', [0.1 0.25]);

%% 5) Frequency-domain low-pass (ideal circular mask)
F = fftshift(fft2(I_enh));
[M, N] = size(F);
[u, v] = meshgrid(-N/2:N/2-1, -M/2:M/2-1);
D0 = 60; % cutoff radius in frequency domain (tune if needed)
H = double(sqrt(u.^2 + v.^2) < D0);
I_lp = real(ifft2(ifftshift(F .* H)));

%% 6) Visualization
figure('Name','Lab6 Pipeline','Position',[100 100 1400 320]);
montage({I, I_filt, I_enh, edges, I_lp}, 'Size', [1 5]);
title('Original | Denoised (Median) | Enhanced | Canny Edges | LP Result');

%% 7) Auto-save figure to /figures (handles folder issues)
outdir = fullfile(pwd, 'figures');
if ~exist(outdir, 'dir'); mkdir(outdir); end
f = gcf;
try
    exportgraphics(f, fullfile(outdir, 'pipeline.png'), 'Resolution', 200);
catch
    % Fallback for older MATLAB: use saveas
    saveas(f, fullfile(outdir, 'pipeline.png'));
end

%% 8) Short report (console)
fprintf('--- Lab 6 Mini Project Report ---\n');
fprintf('1) Median filter reduces impulsive noise while preserving edges.\n');
fprintf('2) imadjust stretches dynamic range for better contrast perception.\n');
fprintf('3) Canny edges highlight object boundaries (gradient + thresholding).\n');
fprintf('4) Ideal LP mask suppresses high-frequency noise/details in frequency domain.\n');
fprintf('5) See figures/pipeline.png for side-by-side results.\n');
