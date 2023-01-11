process shovill {
    /**
    * Assemble bacterial isolate genomes (https://github.com/tseemann/shovill)
    * @input tuple dataset_id, path(forward), path(reverse)
    * @output shovill_out tuple val(dataset_id), path("${dataset_id}.fasta")
    */

    tag { dataset_id }

    cpus 2

    container = "quay.io/climb-big-data/shovill:1.1.0"

    publishDir "${params.output_dir}/${task.process.replaceAll(":", "_")}", mode: 'copy', pattern: '*.fasta'

    input:

      tuple val(dataset_id), path(forward), path(reverse)

    output:

      tuple val(dataset_id), path("${dataset_id}.fasta"), emit: shovill_out

    script:

      """
      shovill --cpus ${task.cpus} --R1 ${forward} --R2 ${reverse} --minlen 500 --outdir shovill
      mv shovill/contigs.fa ${dataset_id}.fasta
      """
}