
# Lab 6: Mini Project – Image Processing Pipeline

**Goal:** combine key DSP image concepts—**filtering**, **frequency**, **edges**, and **enhancement**—into one small pipeline.

## Steps (What & Why)

| Step | Operation | Why it’s used |
|---|---|---|
| 1 | Load grayscale image | Work with intensity for DSP-style processing |
| 2 | Median filtering | Remove salt & pepper noise; preserve edges |
| 3 | Contrast enhancement | Stretch dynamic range (improves visibility) |
| 4 | Edge detection (Canny) | Extract object boundaries based on gradients |
| 5 | Frequency-domain low-pass | Suppress high frequencies in FFT domain |
| 6 | Visualization | Side-by-side results for quick comparison |

## How to Run

1. Open **MATLAB**.
2. (Optional) Replace **`your_image.jpg`** with your own image.
3. Run the script:
   ```matlab
   lab6_image_pipeline
   ```
4. The montage result is auto-saved to **`figures/pipeline.png`**.

## Files

- `lab6_image_pipeline.m` — full MATLAB pipeline.
- `your_image.jpg` — sample grayscale image (so it runs out-of-the-box).
- `figures/` — created automatically with the final montage screenshot.

## Short DSP Notes

- **Median filter (spatial, nonlinear):** good for impulse noise, keeps edges.
- **imadjust (point operation):** maps intensities to use full range.
- **Canny edges:** gradient-based detector with hysteresis thresholds.
- **FFT Low-pass:** masks out high-frequency components; ideal circular mask.

## Submission

Include:
- this **README.md**
- the **`.m`** file
- the saved figure at `figures/pipeline.png` (after you run the script)
