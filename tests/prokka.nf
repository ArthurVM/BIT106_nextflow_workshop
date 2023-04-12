#!/usr/bin/env nextflow

// enable dsl2
nextflow.enable.dsl = 2

// import modules
include {tbfastqs} from '../test-datasets/tbfastqs.nf'
include {shovill} from '../modules/shovill.nf'
include {prokka} from '../modules/prokka.nf'

// define workflow
workflow {

  accession_id='SRR9588019'


  // main workflow
  main:

    tbfastqs(accession_id)

    shovill(tbfastqs.out.tbfastqs_out)

    prokka(shovill.out.shovill_out)

}