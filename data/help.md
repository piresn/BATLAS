
## Introduction: BATLAS deconvolution 

The BATLAS web app will take in a gene expression matrix of samples and genes, and estimate the fraction of brown adipocytes per each sample.

The estimations of brown percentages are done using Digital Sorting Algorithm from the [CellMix package](https://web.cbio.uct.ac.za/~renaud/CRAN/web/CellMix/) in combination with the brown and white markers from our publication (Perdikari et al, in submission).

## Input requirements

- **Format:** a tab-delimited file with ENSEMBL gene identifiers in the first column and sample names in the first row (see example dataset).
- **Supported Species:** Mouse or Human  (e.g. ENSMUSG* or ENSG* identifiers).
- **Expression values:** RPKM or TPM values, or normalized read counts; All cells of the input expression matrix must contain a numeric value >= 0 (use _dot ._ as decimal separator). Files with empty cells or NA cells will be rejected.
- **Sample Names:** No space characters or non-alphanumeric characters (see example dataset).

## How to Run the Analysis
- Click the 'Browse' button under "Load Expression data".
- Select your tab-delimited file and click 'Open'.

The script will then validate the input. If you get the message "Incomplete gene list", and you have uploaded a gene expression matrix that agrees with the requirements above, then it may be that your expression matrix is missing some genes needed for the deconvolution algorithm. Please double check that your have a comprehensive transcriptome reference based on the Ensembl annotation.

The calculation will take several seconds to finish (longer for larger datasets).

## Questions
For questions regarding BATLAS please [contact us](mailto:christian-wolfrum@ethz.ch).

---



