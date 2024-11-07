process trimgalore {
    /**
    * Trims paired fastq using trim_galore (https://github.com/FelixKrueger/TrimGalore)
    * @input tuple dataset_id, project, path(forward), path(reverse)
    * @output trimgalore_out tuple dataset_id, project, path("*_val_1.fq.gz"), path("*_val_2.fq.gz")
    */

    tag { dataset_id }

    publishDir "${baseDir}/${dataset_id}/Trim", mode: 'copy', pattern: '*.trimming_report.txt'

    memory '4GB'

    input:
    tuple val(dataset_id), path(forward), path(reverse)

    output:
    tuple val(dataset_id), path("*_val_1.fq.gz"), path("*_val_2.fq.gz"), emit: trimgalore_out optional true
    path("*trimming_report.txt"), emit: trimgalore_results optional true

    script:
    """
    trim_galore --fastqc --paired ${forward} ${reverse}
    """
}