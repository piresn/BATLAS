
## Introduction: BATLAS deconvolution 

The BATLAS shiny app will take in a gene expression matrix of samples and genes, and estimate the fraction of brown adipocytes per each sample.

The estimations of brown percentages are done using Digital Sorting Algorithm from the CellMix package (https://web.cbio.uct.ac.za/~renaud/CRAN/web/CellMix/) in combination with the brown and white markers from our publication (Aliki et al, in submission).

## Input requirements
- Format: A tab-delimited file with ENSEMBL gene identifiers in the rows and Sample names in the columns (see example dataset)
- Supported Species: Mouse or Human  (e.g. ENSMUSG* or ENSG* identifiers)
- Values: RPKM or TPM values, or normalized read counts.
- Sample Names: No space characters or non-alphanumeric characters (see example dataset)
- All cells of the input expression matrix must contain a value >=0. Data with empty cells (NAs or NULL) with be rejected.

## How to Run the Analysis
- Click the 'Browse' button under "Load Expression data"
- Select your tab-delimited and click 'Open'

The script will then validate the input. If you get the message "Incomplete gene list" , and you have uploaded a gene expression matrix that agrees with the requirements above, then it may be that your expression matrix is missing some genes needed for the deconvolution. Please double check that your have a comprehensive transcriptome reference based on the Ensembl annotation.

When the input is accepted, will take approximately 1-4 mins for the calculation to finish (and longer for larger datasets).

## Questions
For questions regarding the shiny app please contact (myname@myuniv.edu)


