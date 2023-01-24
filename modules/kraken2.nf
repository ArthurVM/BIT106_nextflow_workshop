process kraken2 {
    /**
    * Speciation using kraken2 (https://github.com/DerrickWood/kraken2)
    * @input tuple dataset_id, path(forward), path(reverse)
    * @input path(*.k2d)
    * @output kraken2_out tuple val(dataset_id), path("${dataset_id}_kraken_report.txt")
    */

    tag { dataset_id }

    cpus 2

    container = "quay.io/climb-big-data/kraken2:2.1.2"

    publishDir "${params.outputDir}/${task.process.replaceAll(":", "_")}", mode: 'copy', pattern: '*.txt'

    input:

      tuple val(dataset_id), path(forward), path(reverse)
      path(database)

    output:

      tuple val(dataset_id), path("${dataset_id}_kraken_report.txt"), emit: kraken2_out

    script:

      """
      kraken2 --threads ${task.cpus} --db . --output ${dataset_id}_read_classifications.txt --report ${dataset_id}_kraken_report.txt --paired ${forward} ${reverse}
      """
}