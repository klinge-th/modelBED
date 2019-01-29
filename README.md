# modelBED
Code to calculate the 31x31x31 BED matrix from the exported information of a custom version of Leksell GammaPlan 10.1 using MATLAB.  
The script 'tk_exampleScript.m' shows an example of the usage of the MATLAB functions. It uses a mock data set that was artificially created for this purpose to calculate and plot the BED distribution.

## Quickstart Guide
1. To use this code, clone or download this repository to your local machine. If you have downloaded the .zip folder, unzip it at a convenient location.  
2. Open MATLAB and navigate to the location of the modelBED directory. Note: the example script 'tk_exampleScript.m' can only load the mock data set if it is part of the MATLAB current folder.
3. Execute the script 'tk_exampleScript.m' cell by cell to follow the required steps to calculate and visualise the BED.

## inputs for BED calculation
Arrays like shots (containing the information about every single shot) and the dose are used as they are exported from GammaPlan. Their shape is always the same (with the number of isocentres N):    
* shots:    Nx9 (shot duration in 9th column)  
* dose:     31x31xNx31 array (as exported from LGP, not in X/Y/Z orientation <sup>[1](#myfootnote1)</sup> ) 
* g:        (N-1)x1 array containing the duration of the gap between shots [min]  
 mu_fast:  fast repair-rate (ln(2)/half-time) [1/min]  
* mu_slow:  slow repair-rate (ln(2)/half-time) [1/min]  
* c:        partition coefficient  
* ABratio:  alpha/beta ratio  

<a name="myfootnote1">1</a>: If you use your own dose ditributions, their orientation does not matter as long as the individual 3D dose distributions are iterated along the 3rd dimension of the 4D cube.

