process quast {
    /**
    * Perform quality assessment of genome assemblies using quast (https://github.com/ablab/quast)
    * @input path(fasta)
    * @output prokka_out path("${dataset_id}.fna") 
    */

    cpus 2

    memory '8GB'

     publishDir "${baseDir}/${dataset_id}/", pattern: "transposed_report.tsv", mode: 'copy'

    input:

      tuple val(dataset_id), path(fasta)     

    output:

      path("transposed_report.tsv"), emit: quast_out

    script:

      """
      quast.py -t ${task.cpus} -o . --contig-thresholds 0 --no-html --no-plots *.fasta
      """
}