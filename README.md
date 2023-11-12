# Data-Driven Spatial Filter Selection for Adaptive Brain-Computer Interfaces 
<!--Influence of Morphological and Functional Variability on Surface EEG-->


<p align="center">
    <img width="600" src="/images/csp_selection.jpg" alt="Material Bread logo">
</p>

In the field of motor imagery neurofeedback (MI-NF) and motor imagery brain-computer interface (MI-BCI), studies have consistently reported inter-individual performance variability. 
Investigation of these variabilities has led to the proposition that stable anatomical differences that persist across the lifespan may have predictive value for understanding performance variability in MI-NF and MI-BCI (Grosse et al., 2013). 
Electroencephalography (EEG), with its affordability and high temporal resolution, has been the preferred modality for such investigations, often relying on event-related desynchronization (ERD) as the neural signature. ERD, which represents an amplitude reduction in sensorimotor rhythms during motor activity in the [8-30] Hertz frequency range, is particularly pronounced over contralateral sensorimotor areas during unilateral movement execution. 
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
4. Examine the selected CSP patterns for meaningful relationships to anatomical variability.

### Define ROI based on fMRI data

In this study, due to uncertainty regarding the precise boundaries of hand motor activity in the cortex, individual BOLD signals from fMRI data are used to define the ROI. Cortical areas are extracted individually from the MRI data. 
A first-level analysis is then performed to identify significantly activated vertices on each subject's cortical surface. 
The most activated vertices within the primary motor cortex (M1) and primary somatosensory cortex (S1) are then selected as the ROI for each subject.

<p align="center">
    <img width="800" src="/images/roi_difinition.jpg" alt="Material Bread logo">
</p>

