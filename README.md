# CT-Imaging
This is the home for an ongiong project to showcase how CT imaging works and provide MATLAB code.

<em>Currently a work in progress, new sections will be added and reorganized on a rolling basis.</em>.

This Project has 5 sections, found in 5 folders from the main directory.

## Section 1: MATLAB Introduction

Within this folder, one file containing a few exercises relevent to MATLAB can be found. This is not directly project related, but the code served as a great refresher.

## Section 2: Attenuation Collection

This section covers the creation of CT Data at one instance or angle. 

## Section 3: Sinogram Creation

This section shows how a collection of different views are compiled into an image called a sinogram. This code simulates a CT machine. It should be noted that the simulation excludes many other real world issues, like noise and X-Ray beam distribution.

## Section 4: ART

This is a full demonstration of CT Data Reconstruction. The code from previous sections creates the data, where this code rebuilds ot into images we can interpret.

This is an old algorithm that is not in use. For a more current CT Example search for Fourier Transform.

## Section 5: Metal Artifact Removal

This section deals with metal artifacts in CT Imaging. 




## Starting Point

sinogram_generator.m is the main file, start there. The sinogram iscreated by projection.m



