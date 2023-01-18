#!/usr/bin/env nextflow

// enable dsl2
nextflow.enable.dsl = 2

// import modules
include {trimgalore} from '../modules/trimgalore.nf'
include {shovill} from '../modules/shovill.nf'

// define workflow
workflow {

  Channel.fromSRA('SRR9588019')
         .set{ input_fq }


  // main workflow
  main:

    trimgalore(input_fq)
    shovill(trimgalore.out.trimgalore_out)

}