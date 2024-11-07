#!/usr/bin/env nextflow

// enable dsl2
nextflow.enable.dsl = 2

// import modules
// modules must be imported before they are called
// correct syntax is:
//    include {process_name} from '/PATH/TO/MODULE/SCRIPTS/process_name.nf'


// define workflow
workflow {

  // 0. Parse arguments.
  //    When executing the script, arguments are specified using '--my_argument some_value' syntax.
  //
  //    required arguments:
  //        - input_dir: this should be the full path to a directory containing paired end FASTQ files (N.B. this must end with /).
  //        - pattern: the glob suffix pattern to pair reads with using wildcards (e.g. "*_{1,2}.fastq.gz").
  //        - afanc_db: the full path to the afanc database.
  //
  // Arguments will be accessible in the script using the 'param.my_argument' syntax.
  //
  // A FASTQ-grouping should be constructed with 'input_dir' and 'pattern' arguments using 'input_dir + pattern' and then passed to factory method to create a Channel:
  //     Channel.fromFilePairs(FASTQ-grouping, flat: true).set{input_files}


  // main workflow
  main:

    // Output from a process can be accessed using the 'my_process.out.output_variable' syntax.
    // The output variable name is defined in the process itself.

    // 1. Trim the reads using Trimgalore (include input_files argument).


    // 2. Assemble reads using Shovill.


    // 3. Determine species in the sample using Afanc (include afanc_db argument).


    // 4. Perform AMR prediction using Abricate.


    // 5. Get quality control statistics using QUAST.


}