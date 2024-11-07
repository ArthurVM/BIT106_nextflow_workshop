process centrifugedb {

    output:
    path("*.cf"), emit: centrifugedb_out

    script:
    """
    wget https://genome-idx.s3.amazonaws.com/centrifuge/p_compressed_2018_4_15.tar.gz

    tar -xf p_compressed_2018_4_15.tar.gz
    """
}