# Test of -resume intuition

Trivial example that takes a CSV as input and causes a failure if the second column is "true"

Running with the original sample sheet that contains these failure samples should cause a nextflow failure:

    ./nextflow run test.nf --input_csv original_input.csv -resume

Removing those problematic samples and using -resume should grabbed cached results and complete execution for only the 50 samples in the clean sample sheet.

    ./nextflow run test.nf --input_csv clean_input.csv -resume

You can check how far each sample has progressed by looking in `test_out` after a run and seeing which of the 3 step output files are in a given samples directory. 

e.g., sample 0 was a failure sample so only contains step1 output but sample 1 contains all 3 outputs.

    test_out
    ├── 0
    │   └── 0.step1.txt
    └── 1
        ├── 1.step1.txt
        ├── 1.step2.txt
        └── 1.step3.txt
