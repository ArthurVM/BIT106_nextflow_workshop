process prokka {
    /**
    * Annotate bacterial, archaeal and viral genomes using prokka (https://github.com/tseemann/prokka)
    * @input tuple dataset_id, path(fasta)
    * @output prokka_out path("${dataset_id}.fna") 
    */

    tag { dataset_id }

    cpus 2

    container = "quay.io/climb-big-data/prokka:1.14.5"

    publishDir "${params.outputDir}/${task.process.replaceAll(":", "_")}", mode: 'copy', pattern: "${dataset_id}/${dataset_id}.*", mode: 'copy'

    input:

      tuple val(dataset_id), path(fasta)      

    output:

      tuple val(dataset_id), path("${dataset_id}.fna"), emit: prokka_out

    script:

      """
      prokka --outdir ${dataset_id} --locustag ${dataset_id} --prefix ${dataset_id} --cpus ${task.cpus} --compliant ${fasta}
      cp ${dataset_id}/${dataset_id}.fna ${dataset_id}.fna
      """
}