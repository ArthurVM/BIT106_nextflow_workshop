process abricate {
    /**
    * Call antimicrobial resistance (https://github.com/tseemann/abricate)
    * @input tuple dataset_id, path(fasta)
    * @output abricate_out tuple val(dataset_id), path("resistance_genes.csv")
    */

    tag { dataset_id }

    container = "quay.io/climb-big-data/abricate:1.0.0"

    publishDir "${params.output_dir}/${task.process.replaceAll(":", "_")}", mode: 'copy', pattern: '*.csv'

    input:

      tuple val(dataset_id), path(fasta)

    output:

      tuple val(dataset_id), path("resistance_genes.csv"), emit: abricate_out

    script:

      """
      abricate --db resfinder --csv ${fasta} > resistance_genes.csv
      """
}