process centrifuge {
    /**
    * Speciation using centrifuge (hhttps://github.com/DaehwanKimLab/centrifuge)
    * @input tuple dataset_id, path(forward), path(reverse)
    * @input path(*.cf)
    * @output centrifuge_out tuple val(dataset_id), path("${dataset_id}_centrifugereport.tab")
    */

    tag { dataset_id }

    cpus 2

    memory '8GB'

    container = "quay.io/climb-big-data/centrifuge:1.0.4"

    publishDir "${params.outputDir}/${task.process.replaceAll(":", "_")}", mode: 'copy', pattern: '*.tab'

    input:

      tuple val(dataset_id), path(forward), path(reverse)
      path(database)

    output:

      tuple val(dataset_id), path("${dataset_id}_centrifugereport.tab"), emit: centrifuge_out

    script:

      """
      centrifuge -q -p ${task.cpus} -x p_compressed -1 ${forward} -2 ${reverse} -S /dev/null --report-file ${dataset_id}_centrifugereport.tab
      """
}