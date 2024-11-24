process afanc {
    /**
    * Call TB species using afanc (https://github.com/ArthurVM/Afanc)
    * @input tuple dataset_id, path(forward), path(reverse)
    * @output afanc_out tuple val(dataset_id), path("${dataset_id}_mykrobe_report.json")
    */

    tag { dataset_id }

    cpus 2

    memory '13GB'

    publishDir "${baseDir}/${dataset_id}/Afanc", mode: 'copy', pattern: '*.json'

    input:

      tuple val(dataset_id), path(forward), path(reverse)
      path(afanc_db)

    output:

      tuple val(dataset_id), path("${dataset_id}.json"), emit: afanc_out

    script:

      """
      afanc screen --threads ${task.cpus}  -o ${dataset_id} ${afanc_db} ${forward} ${reverse}
      mv ${dataset_id}/${dataset_id}.json ./
      """
}
