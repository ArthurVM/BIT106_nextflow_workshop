#!/usr/bin/env nextflow

// enable dsl2
nextflow.enable.dsl = 2

// import modules
include {tbfastqs} from '../test-datasets/tbfastqs.nf'
include {trimgalore} from '../modules/trimgalore.nf'

// define workflow
workflow {

  accession_id='SRR9588019'


  // main workflow
  main:

    tbfastqs(accession_id)
    trimgalore(tbfastqs.out.tbfastqs_out)

}
