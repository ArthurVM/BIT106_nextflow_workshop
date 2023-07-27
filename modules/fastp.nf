process fastp {
    /**
    * Clean reads using fastp (https://github.com/OpenGene/fastp)
    * @input tuple dataset_id, path(forward), path(reverse)
    * @output fastp_out tuple val(dataset_id), path("${dataset_id}_cleaned_1.fq.gz"), path("${dataset_id}_cleaned_2.fq.gz")
    * @output fastp_report tuple val(dataset_id), path("${dataset_id}_fastp.json"), path("${dataset_id}_fastp.html")
    */

    tag { dataset_id }

    cpus 1

    memory '4GB'

    container = "quay.io/climb-big-data/fastp:0.23.2"

    publishDir "${params.output_dir}/${task.process.replaceAll(":", "_")}", mode: 'copy', pattern: '*_fastp.json'
    publishDir "${params.output_dir}/${task.process.replaceAll(":", "_")}", mode: 'copy', pattern: '*.fq.gz'

    input:

      tuple val(dataset_id), path(forward), path(reverse)

    output:

      tuple val(dataset_id), path("${dataset_id}_cleaned_1.fq.gz"), path("${dataset_id}_cleaned_2.fq.gz"), emit: fastp_out
      tuple val(dataset_id), path("${dataset_id}_fastp.json"), path("${dataset_id}_fastp.html"), emit: fastp_report

    script:

      clean_fq1  = "${dataset_id}_cleaned_1.fq.gz"
      clean_fq2  = "${dataset_id}_cleaned_2.fq.gz"
      fastp_json = "${dataset_id}_fastp.json"
      fastp_html = "${dataset_id}_fastp.html"

      """
      fastp -i ${forward} -I ${reverse} -o ${clean_fq1} -O ${clean_fq2} -j ${fastp_json} -h ${fastp_html} --length_required 50 --average_qual 10 --low_complexity_filter --correction --cut_right --cut_tail --cut_tail_window_size 1 --cut_tail_mean_quality 20
      """
}