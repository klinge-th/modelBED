# modelBED
Code to calculate the 31x31x31 BED matrix from the exported information of a custom version of Leksell GammaPlan 10.1 using MATLAB.  
The script tk_exampleScript.m shows an example of the usage of the MATLAB functions. It uses a mock data set that was artificially created for this purpose to calculate and plot the BED distribution.

# inputs for BED calculation
Arrays like shots (containing the information about every single shot) and the dose are used as they are exported from GammaPlan. Their shape is always the same (with the number of isocentres N):    
shots:    Nx9 (shot duration in 9th column)  
dose:     31x31xNx31 array (as exported from LGP, not in X/Y/Z orientation)
g:        (N-1)x1 array containing the duration of the gap between shots [min]  
mu_fast:  fast repair-rate (ln(2)/half-time) [1/min]  
mu_slow:  slow repair-rate (ln(2)/half-time) [1/min]  
c:        partition coefficient  
ABratio:  alpha/beta ratio  
