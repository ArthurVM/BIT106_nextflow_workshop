#!/usr/bin/env nextflow

// enable dsl2
nextflow.enable.dsl = 2

// import modules
include {tbfastqs} from '../test-datasets/tbfastqs.nf'
include {fastp} from '../modules/fastp.nf'

// define workflow
workflow {

  accession_id='SRR9588019'


  // main workflow
  main:

    tbfastqs(accession_id)
    fastp(tbfastqs.out.tbfastqs_out)

}