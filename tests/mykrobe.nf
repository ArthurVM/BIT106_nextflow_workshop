#!/usr/bin/env nextflow

// enable dsl2
nextflow.enable.dsl = 2

// import modules
include {tbfastqs} from '../test-datasets/tbfastqs.nf'
include {mykrobe} from '../modules/mykrobe.nf'

// define workflow
workflow {

  accession_id='SRR9588019'


  // main workflow
  main:

    tbfastqs(accession_id)
    mykrobe(tbfastqs.out.tbfastqs_out)

}
