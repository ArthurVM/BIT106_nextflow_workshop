process mykrobe {
    /**
    * Call antimicrobial resistance using mykrobe (https://github.com/Mykrobe-tools/mykrobe)
    * @input tuple dataset_id, path(forward), path(reverse)
    * @output mykrobe_out tuple val(dataset_id), path("${dataset_id}_mykrobe_report.json")
    */

    tag { dataset_id }

    cpus 2

    container = "quay.io/climb-big-data/mykrobe:0.12.1"

    publishDir "${params.output_dir}/${task.process.replaceAll(":", "_")}", mode: 'copy', pattern: '*_mykrobe_report.json'

    input:

      tuple val(dataset_id), path(forward), path(reverse)

    output:

      tuple val(dataset_id), path("${dataset_id}_mykrobe_report.json"), emit: mykrobe_out

    script:

      """
      mykrobe predict --sample ${dataset_id} --species tb --threads ${task.cpus} --format json --output ${dataset_id}_mykrobe_report.json -1 ${forward} ${reverse}
      """
}
