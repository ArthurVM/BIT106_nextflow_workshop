process krakendb {

    output:
    path("*k2d"), emit: krakendb_out

    script:
    """
    wget https://genome-idx.s3.amazonaws.com/kraken/k2_pluspf_08gb_20221209.tar.gz

    tar -xf k2_pluspf_08gb_20221209.tar.gz
    """
}