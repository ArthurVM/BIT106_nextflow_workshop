process quast {
    /**
    * Perform quality assessment of genome assemblies using quast (https://github.com/ablab/quast)
    * @input tuple dataset_id, path(fasta)
    * @output prokka_out path("${dataset_id}.fna") 
    */

    tag { dataset_id }

    cpus 2

    container = "quay.io/climb-big-data/quast:5.2.0"

    publishDir "${params.outputDir}/${task.process.replaceAll(":", "_")}", pattern: "transposed_report.tsv", mode: 'copy'

    input:

      tuple val(dataset_id), path(fasta)      

    output:

      path("transposed_report.tsv"), emit: quast_out

    script:

      """
      quast.py -t ${task.cpus} -o . --contig-thresholds 0 --no-html --no-plots *.fasta
      """
}