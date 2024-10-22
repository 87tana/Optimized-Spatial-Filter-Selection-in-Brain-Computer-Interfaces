# Optimized Spatial Filter Selection in Brain-Computer Interfaces: A Data-Driven Approach
<!--Influence of Morphological and Functional Variability on Surface EEG-->


<p align="center">
    <img width="900" src="/images/csp_selection.jpg" alt="Material Bread logo">
</p>

In the field of motor imagery neurofeedback (MI-NF) and motor imagery brain-computer interface (MI-BCI), studies have consistently reported inter-individual performance variability. 
Investigation of these variabilities has led to the proposition that stable anatomical differences that persist across the lifespan may have predictive value for understanding performance variability in MI-NF and MI-BCI (Grosse et al., 2013). 
Electroencephalography (EEG), with its affordability and high temporal resolution, has been the preferred modality for such investigations, often relying on event-related desynchronization (ERD) as the neural signature. ERD, which represents an amplitude reduction in **sensorimotor rhythms** during motor activity in the [8-30] Hertz frequency range, is particularly pronounced over contralateral sensorimotor areas during unilateral movement execution. 
Despite the advantages of EEG, it is imperative to mitigate the effects of volume conduction by spatial filtering. 
Common Spatial Patterns (CSP) stand out as one of the most effective spatial filtering methods, generating subject-specific spatial filters through EEG signal decomposition.
The selection of CSP filters taking into account inter-individual specificities is considered crucial for improving rehabilitation outcomes. 
However, the current landscape lacks a systematic approach for filter selection, often relying on empirical methods or heuristic guidelines, as illustrated by plausible and implausible CSPs according to the Niclas Braun's guidelines used in this study.

<p align="center">
    <img width="500" src="/images/plausible_csp_example.jpg" alt="Material Bread logo">
</p>

## Aim of Study
The **hypothesis** is that anatomical variabilities can help explain the variability of scalp-level EEG patterns and CSP patterns.
Therefore, the **aim of this study** is to investigate the correlations between inter-individual anatomical variabilities and scalp-level EEG patterns in order to evaluate two CSP selection approaches that take anatomical information into account. 
In particular, two anatomical variabilities were considered: 
- the morphological variability of the hand knob (HK), a key area in the motor cortex,
- the percentage of cortical activity during hand motor execution in the gyrus. 

The HK, located anterior to the central sulcus, exhibits a knob-like structure that varies across hemispheres and subjects, as illustrated by five variants: Omega, M-Epsilon, Epsilon, L-Epsilon, and Null. The study also explores the plausibility of the selected CSPs based on anatomical information.

<p align="center">
    <img width="600" src="/images/hand_knob.jpg" alt="Material Bread logo">
</p>

## Dataset

This study involves the re-analysis of a separately recorded EEG—(f)MRI dataset comprising 20 healthy older adults ranging in age from 48 to 77 years, with a mean age of 61.4 years (Meekes et al., 2017).
<p align="center">
    <img width="250" src="/images/data_modalities.jpg" alt="Material Bread logo">
</p>

The dataset focuses on the task of hand motor execution, specifically closing and opening actions in a pseudo-random order, with 20 trials:
- Rest: 5-9 s 
- Cue: 3 s 
- Execution: 5 s

## Methodology
The study steps are as follows:
1. Define the region of interest (ROI) for each subject based on individual functional information. 
2. Simulate the cortical activity associated with hand motor execution to obtain EEG patterns at the scalp using forward modeling.
3. Use the simulated pattern for each individual to select a CSP pattern. 

### Define ROI based on fMRI data

In this study, due to uncertainty regarding the precise boundaries of hand motor activity in the cortex, individual BOLD signals from fMRI data are used to define the ROI. Cortical areas are extracted individually from the MRI data. 
A first-level analysis is then performed to identify significantly activated vertices on each subject's cortical surface. 
The most activated vertices within the primary motor cortex (M1) and primary somatosensory cortex (S1) are then selected as the ROI for each subject.

<p align="center">
    <img width="800" src="/images/roi_definition.jpg" alt="Material Bread logo">
</p>

### Simulate EEG patterns

In this step, the EEG voltage distributions were simulated at the scalp level. The EEG electrodes and cortical surfaces were co-registered. 
A forward model was then computed using the symmetric boundary element method (BEM) to estimate volume conduction, and the source was modeled using the minimum norm estimation method. 
The results included head and source models. The ROI was then seeded with a uniform signal, and the head and source models were used to simulate scalp-level EEG patterns.

<p align="center">
    <img width="300" src="/images/forward_model.jpg" alt="Material Bread logo">
</p>

<p align="center">
    <img width="800" src="/images/simulate_eeg.jpg" alt="Material Bread logo">
</p>

### CSP selection approaches

In this study, two different approaches to CSP pattern selection are explored, namely BCOR and BQS.

#### BCOR
In BCOR, the correlation (COR) between the simulated pattern and all available CSP patterns is calculated for each subject. 
The CSP with the highest correlation value is then selected, based on the assumption that it is the most anatomically plausible for the subject.

#### BQS
In BQS, CSPs with significant correlations to the simulated patterns and substantial ERD are sought by maximizing the Quadratic Score (QS), where QS is the product of COR and ERD, scaled between 0 and 1. 
For each ERD component (ERD<sub>i</sub>), a bandpass filter was applied to the EEG signal, followed by epochs from 0.5 to 5 seconds after the onset of execution and 7.5 to 3 seconds before the onset of rest. 
After artifact rejection and application of CSP<sub>i</sub>, ERD was calculated using a formula based on signal power. The result was averaged over time, epochs, and channels to obtain a scalar value.

<p align="center">
    <img width="800" src="/images/bqs_overview.jpg" alt="Material Bread logo">
</p>

**Example:** CSP3 showed the highest correlation with the simulated pattern, albeit with a small ERD. 
Conversely, CSP1 had the largest ERD, but with a small COR. Notably, CSP2 had the highest QS, with both a significant COR and ERD.

<p align="center">
    <img width="800" src="/images/bcor_example.jpg" alt="Material Bread logo">
</p>


## Results
In this section, the selected CSP patterns are assessed for meaningful relationships to anatomical variability.
Means and standard deviations (SD) are calculated to summarize the resulting patterns. The figures show substantial correlations between the simulated patterns for both hemispheres. 
The mean simulated pattern is centered on the sensorimotor area, with the SD deviating only slightly from the mean. 
As for the selected CSPs based on both approaches, they generally represent hand motor activity, with means concentrated in the sensorimotor area. 
However, the SD values show that the patterns are distributed throughout the head, with significant deviations from the mean for different subjects.

<p align="center">
    <img width="500" src="/images/result1.jpg" alt="Material Bread logo">
</p>

### Influence of hand knob variants
To assess whether anatomical differences in HK could lead to different surface patterns, the correlation between simulated patterns is calculated to measure differences and similarities between individuals. 
This served as a distance measure between individuals. Due to insufficient samples of all the knob variants, subjects are divided into two groups: one with Omega and one with other knob variants.

<p align="center">
    <img width="200" src="/images/group_size.jpg" alt="Material Bread logo">
</p>

Differences in correlations between subjects with Omega variants and those with other variants were analyzed using a two-sample t-test. 
The results, shown in the table, indicate that only the selected CSPs based on BCOR in the right hemisphere of subjects with Omega variants are significantly different from those with other knob variants. 
However, the overall surface patterns are almost identical between individuals, suggesting a negligible role of the hand knob in this study.

<p align="center">
    <img width="250" src="/images/result_hk_influence1.jpg" alt="Material Bread logo">
</p>

### Influence of gyral activity

To assess the role of gyral activity, subjects are ordered by the percentage of their ROIs that lay in the gyrus. 
The resulting plot shows a monotonically decreasing pattern with no inflection point, which prevented the subjects from being grouped for a t-test.

<p align="center">
    <img width="350" src="/images/gyral_order.jpg" alt="Material Bread logo">
</p>

To examine gyrus activity in more detail, each pair of subjects is plotted against two features: their correlation score and the difference between their gyrus activities. 
The plot shows no linear relationship between the subjects' correlations and their gyral activities, meaning that there is no meaningful relationship between gyral activity and the subjects' simulated patterns and CSPs.

<p align="center">
    <img width="800" src="/images/result2.jpg" alt="Material Bread logo">
</p>

### Relationship between COR, ERD, and plausibility
To better understand the relationship between COR, ERD, and plausibility, the selected CSPs are sorted by their COR values and their plausibility is examined based on the Niclas guidelines. In the figure, the red curve represents the COR values and the blue curve represents the ERD values. Typically, the first CSPs are more plausible for both criteria, although there are exceptions. For example, C08 has the best correlation but seems less plausible than C13. A comparison of COR and ERD shows that in many cases a large COR value coincides with a large ERD, but this correlation is not consistent. Impractical CSPs often have small ERDs, but the reverse is not necessarily true, suggesting that COR and ERD may have different importance in CSP selection for different subjects.

<p align="center">
    <img width="550" src="/images/result_plausibility.jpg" alt="Material Bread logo">
</p>

### Average anatomical information for CSP selection

As observed, significant correlations were found between the mean and SD simulation patterns. This suggests the hypothesis that using the mean simulated pattern may yield similar CSP selections compared to individual patterns. To test this, the mean simulated pattern is used in both CSP selection criteria. The resulting plots show the correlation between CSPs selected based on the mean and individual simulated patterns. For more than half of the subjects, the same CSP is chosen by both the mean and individual patterns. The table summarizes the results, showing that 45% of the cases selected the same plausible CSPs, 19% selected the same implausible CSPs, 10% selected different implausible CSPs, 11% selected only the plausible CSP selected by average information, and 15% required individual anatomy to select plausible CSPs.

<p align="center">
    <img width="800" src="/images/result_average_anatomical.jpg" alt="Material Bread logo">
</p>

## Conclusion

The results did not show any meaningful pattern to verify a relationship between the considered anatomical variabilities and the simulated EEG voltage distribution at the scalp level and the selected CSPs.

### Factors influencing the results

**1. Simulation accuracy:** 
The accuracy of the simulation used to derive anatomical information and compare it to CSP patterns may not be sufficient to interpret anatomical variability at the sensor level. Factors affecting the accuracy of the simulation include:
- Errors in forward and source modeling.
- The simulation does not account for individual characteristics such as age, which is important in this study.
- The simulation procedure does not take into account certain cortical and non-cortical activities that influence real EEG data and consequently CSPs. This discrepancy between simulated and real EEG patterns is evident in the histogram of correlations between subjects' simulated patterns and CSPs, where simulated patterns show high correlation while CSPs differ from each other.

<p align="center">
    <img width="600" src="/images/simulation_error1.jpg" alt="Material Bread logo">
</p>
  
**2. Separate recording of EEG and fMRI:**
The potential influence of different session conditions on cortical activities is a consideration. The use of fMRI data for ROI definition and simulation, followed by comparison of simulation results with real EEG data for CSP selection, may be affected by possible differences in the source localization of activities between EEG and fMRI. 
To mitigate these problems, simultaneous recording of both data types (Huster et al., 2012) or using EEG data for source localization and ROI definition could be explored.


**3. Band-pass filter with a fixed frequency window:**
Applying a band-pass filter with a fixed frequency window could affect the results, potentially removing a significant portion of the alpha power for some subjects. 
Alpha frequency is known to be a trait-like variable that can vary between subjects due to factors such as age. Given the range in age of the subjects (48 to 77 years), their alpha peak could be close to 8 Hz. 
Setting the lower limit of the filter at 8 Hz could result in the loss of some of the alpha power for some older subjects, which could affect the accuracy of the computed CSPs and ERDs for further analysis.

<p align="center">
    <img width="600" src="/images/band_pass_error.jpg" alt="Material Bread logo">
</p>

**4. Mean and variance of ages:**
According to the literature, activity patterns in mu and beta are known to be more widespread and symmetrical in older adults (Kaiser et al., 2011). 
This may have influenced our results, as the mean and diversity of the subjects' ages may affect the calculated CSPs and ERDs. As a result, comparing subjects based on their CSPs and ERDs may not be reliable for statistically evaluating our hypothesis.

**5. Imperfection of extracted cortical surface:**
The imperfection of the extracted cortical surface may affect the source space and thus the simulation results. Handles and bumps on the surface can displace current dipoles from their true positions and affect their orientation. For example, gyral dipoles may fall into sulci and vice versa. This discrepancy in source space could lead to inaccurate EEG patterns at the scalp level, since the accuracy of the forward model is highly dependent on the accuracy of the source space.

<p align="center">
    <img width="150" src="/images/handle_bump.jpg" alt="Material Bread logo">
</p>

**6. Unbalance and limited diversity of hand knob variants:**
The unbalanced number of samples of different HK types limited the statistical analysis. Future studies should consider increasing the diversity of knob samples in their datasets.

<p align="center">
    <img width="250" src="/images/hk_statistics.jpg" alt="Material Bread logo">
</p>


### Exploring CSP's plausibility

According to the previous study (Zich, 2017), the application of plausible CSP filters is crucial, especially in the context of MI-NF, as they can enhance cortical reorganization of the sensorimotor area, which plays a key role in brain plasticity and, consequently, motor recovery after stroke. Examination of the CSPs selected by BCOR and BQS showed that for some subjects, both approaches led to the selection of plausible CSPs. However, for some other subjects, only one of the approaches could select plausible CSPs, and there are also some subjects for whom both selected CSPs were implausible. The results suggest that both COR and ERD are important for a CSP to be plausible. While a large COR ensures that the CSP pattern follows the pattern of the simulation results, a large ERD ensures the lateralization strength of the CSP. However, the importance of COR and ERD may vary between subjects depending on inter-individual differences and the quality of the EEG signals.
</br>
</br>
While COR can be considered a significant measure of plausibility, ERD cannot always reliably assess plausibility as it may be influenced by other factors such as co-occurrence of irrelevant activities that affect alpha rhythm, inter-individual differences in resting state SMR.
Blankertz (Blankertz et al., 2010) evaluated the correlation between resting state SMR and BCI performance. They showed that there are inter-individual differences in the power of resting state SMR and that it can be used to predict BCI performance.

### Summary

- The results did not show a direct correspondence between the anatomical variabilities considered and neither the simulated EEG patterns nor the selected CSPs.
- However, this study was influenced by a number of factors, such as data recording, ROI selection, simulation conditions, data preprocessing, and unbalanced data set, which should be considered in future studies.
- This study also showed that the proposed CSP selection methods based on anatomical information can select plausible CSPs in about 70% of the cases.

<p align="center">
    <img width="250" src="/images/bcor_vs_bqs.jpg" alt="Material Bread logo">
</p>

- In addition, the results indicated that both COR and ERD are important for a CSP to be plausible. While a large COR ensures the CSP pattern according to the simulation results, a large ERD ensures the lateralization strength of the CSP.
- However, the importance of COR and ERD might vary across subjects, depending on inter-individual peculiarities and the quality of EEG signals.
- Moreover, the results showed that the implausible CSPs usually come with poor ERD, but the other way around does not hold. 
- Finally, the results showed that only in 15% of the cases individual anatomy was necessary to select plausible CSPs, for the rest the average anatomical information was sufficient.

<p align="center">
    <img width="250" src="/images/plausible_csp_statistics.jpg" alt="Material Bread logo">
</p>

## References:

- Braun N., Heuristics for selection of appropriate patterns/filters for motor imagery BCI.
- Blankertz, B., et al. (2010). Neurophysiological predictor of SMR-based BCI performance. Neuroimage, 51(4):1303-1309.
- Grosse-Wentrup, M., et al. (2013). Brain-Computer Interface Research: A State-of-the-Art Summary. Springer, Berlin, Heidelberg.
- Huster, R. J., et al. (2012). Methods for simultaneous EEG-fMRI: an introductory review. Journal of Neuroscience, 32(18):6053-6060.
- Kaiser, V., et al. (2011). First step toward a motor imagery based stroke BCI: New strategy to setup a classifier. Frontiers in Neuroscience, 5, 86.
- Klimesch, W. (1997). EEG-alpha rhythms and memory processes. International Journal of Psychophysiology, 26(1):319-340.
- Meekes, J., et al. (2017). P 69 assessing the relation between brain structure and function during motor imagery in stroke patients and controls using EEG and MRI. Clinical Neurophysiology, 128(10):e362.
- Zich, C. (2017). Characterizing signatures of motor imagery in younger and older adults using multimodal neuroimaging. PhD thesis, Carl von Ossietzky Universität Oldenburg.
