nextflow.enable.dsl=2

process step1 {
    publishDir "test_out/${name}", mode: "copy"
    input:
        tuple val(name), val(condition)
    output:
        tuple val(name), val(condition), path("*.step1.txt")
    script:
        """
        echo "step1" > ${name}.step1.txt
        """
}


process step2 {
    publishDir "test_out/${name}", mode: "copy"
    input:
        tuple val(name), val(condition), path(log)
    output:
        tuple val(name), val(condition), path("*.step2.txt")
    script:
        """
        if [ $condition == "true" ]
        then
            exit 1
        else
            echo "step2,$condition" > ${name}.step2.txt
        fi
        """
}


process step3 {
    publishDir "test_out/${name}", mode: "copy"
    input:
        tuple val(name), val(condition), path(log)
    output:
        tuple val(name), val(condition), path("*.step3.txt")
    script:
        """
        echo "step3" > ${name}.step3.txt
        """
}


workflow {
    data = Channel.fromPath(params.input_csv)
                  .splitCsv(header:true)
                  .map{ row -> tuple(row.sample, row.failure) }
    step1_out = step1(data)
    step2_out = step2(step1_out)
    step3_out = step3(step2_out)
}
