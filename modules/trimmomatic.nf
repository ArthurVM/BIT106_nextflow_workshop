process trimmomatic {
    /**
    * Trim adapters from reads (https://github.com/usadellab/Trimmomatic)
    * @input tuple sample_id, path(forward), path(reverse)
    * @output trim_paired tuple sample_id, path("*_fp.fq"), path("*_rp.fq")
    * @output trim_unpaired tuple sample_id, path("*_fu.fq.gz"), path("*_ru.fq.gz")
    */

    tag { dataset_id }

    cpus 2

    container = "quay.io/climb-big-data/trimmomatic:0.39"

    publishDir "${params.outputDir}/${dataset_id}/${task.process.replaceAll(":", "_")}", pattern: "*_{fp,rp}.fq", mode: 'copy'

    input:
    tuple val(dataset_id), path(forward), path(reverse)

    output:
    tuple val(dataset_id), path("*_fp.fq"), path("*_rp.fq"), emit: trim_paired
    tuple val(dataset_id), path("*_fu.fq.gz"), path("*_ru.fq.gz"), emit: trim_unpaired

    script:

    """
    if [[ \$(zcat ${forward} | head -n4 | wc -l) -eq 0 ]]; then
      exit 0
    else
      trimmomatic PE ${forward} ${reverse} -threads ${task.cpus} -phred33 ${dataset_id}_fp.fq ${dataset_id}_fu.fq.gz ${dataset_id}_rp.fq ${dataset_id}_ru.fq.gz
    fi
    """
}