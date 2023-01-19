# modules
Nextflow modules for CLIMB-BIG-DATA. Tested using GitHub Actions and MRC-CLIMB/containers

## Test pipeline
An example pipeline using the modules is included in `test-pipeline`. The pipeline pulls a pair of test fastqs from the ENA, trims the fastq with trimgalore, and creates an assembly using shovill. The output files from the pipeline are published in an output directory set by `params.outputDir` in `test-pipeline/nextflow.config`

The pipeline requires a version of Nextflow that supports DSL2. To download the latest version of Nextflow:
```
curl -fsSL https://get.nextflow.io | bash
```

The pipeline is designed to run with either docker `-profile docker` or singularity `-profile singularity` (see `test-pipeline/nextflow.config`). On first execution of the pipeline, the required container images will be pulled from the CLIMB-BIG-DATA quay.io repository. E.g. to run the pipeline with docker:
```
git clone https://github.com/MRC-CLIMB/modules.git
cd modules/test-pipeline
nextflow run main.nf -profile docker
```

By default, the pipeline will just run on the local machine. To run on a cluster, modifications will have to be made to the nextflow.config to add in the executor. E.g. for a SLURM cluster add `process.executor = 'slurm'`. For more information on executor options see the Nextflow docs: https://www.nextflow.io/docs/latest/executor.html
