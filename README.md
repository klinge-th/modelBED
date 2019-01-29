# modelBED
Code to calculate the 31x31x31 BED matrix from the exported information of a custom version of Leksell GammaPlan 10.1.

# inputs
Arrays like shots (containing the information about every single shot) and the dose are used as they are exported from GammaPlan. Their shape is always the same (with the number of isocentres N):  
shots: Nx9  
dose: 31x31xNx31
