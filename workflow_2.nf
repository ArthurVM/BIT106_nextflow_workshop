#!/usr/bin/env nextflow

// enable dsl2
nextflow.enable.dsl = 2

// import modules
// modules must be imported before they are called
// correct syntax is:
//    include {process_name} from '/PATH/TO/MODULE/SCRIPTS/process_name.nf'


// define workflow
workflow {

  // main workflow
  main:

    // Output from a process can be accessed using the 'my_process.out.output_variable' syntax.
    // The output variable name is defined in the process itself.

    // 1. Download a pair of test FASTQs from ENA


    // 2. Trim the reads using Trimgalore


    // 3. Assemble reads using Shovill


    // 4. Determine species in the sample using Afanc


    // 5. Perform AMR prediction using Abricate


    // 6. Get quality control statistics using QUAST


}