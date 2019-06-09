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
* dose:     31x31x31xN array (as exported from LGP, not in X/Y/Z orientation <sup>[1](#myfootnote1)</sup> ) 
* g:        (N-1)x1 array containing the duration of the gap between shots [min]  
 mu_fast:  fast repair-rate (ln(2)/half-time) [1/min]  
* mu_slow:  slow repair-rate (ln(2)/half-time) [1/min]  
* c:        partition coefficient  
* ABratio:  alpha/beta ratio  

<a name="myfootnote1">1</a>: If you use your own dose ditributions, their orientation does not matter as long as the individual 3D dose distributions are iterated along the 4th dimension of the 4D cube.

## publications of interest
* W. T. Millar and P. A. Canney, ‘Derivation and application of equations describing the effects of fractionated protracted irradiation, based on multiple and incomplete repair processes. Part I. Derivation of equations.’, Int. J. Radiat. Biol., vol. 64, no. 3, pp. 275–91, Sep. 1993.
* L. A. Pop, W. T. Millar, M. van der Plas, and A. J. van der Kogel, ‘Radiation tolerance of rat spinal cord to pulsed dose rate (PDR-) brachytherapy: the impact of differences in temporal dose distribution’, Radiother. Oncol., vol. 55, no. 3, pp. 301–315, 2000.
* J. W. Hopewell, W. T. Millar, and C. Lindquist, ‘Radiobiological principles: their application to gamma knife therapy.’, Prog. Neurol. Surg., vol. 25, pp. 39–54, 2012.
* J. W. Hopewell, W. T. Millar, C. Lindquist, H. Nordström, P. Lidberg, and J. Gårding, ‘Application of the concept of biologically effective dose (BED) to patients with Vestibular Schwannomas treated by radiosurgery.’, J. Radiosurgery SBRT, vol. 2, no. 4, 2013.
* J. W. Hopewell, W. T. Millar, I. Paddick, and C. Lindquist, ‘Impact of Decaying Dose-rate in Gamma Knife Radiosurgery’, J. Radiosurgery SBRT, vol. 2, no. 3, pp. 251–253, 2013.
* W. T. Millar et al., ‘The role of the concept of biologically effective dose (BED) in treatment planning in radiosurgery.’, Phys. Medica PM Int. J. Devoted Appl. Phys. Med. Biol. Off. J. Ital. Assoc. Biomed. Phys. AIFB, vol. 31, no. 6, pp. 627–33, Sep. 2015.
* B. Jones and J. W. Hopewell, ‘Modelling the influence of treatment time on the biological effectiveness of single radiosurgery treatments: derivation of “protective” dose modification factors’, Br. J. Radiol., p. 20180111, Aug. 2018.
