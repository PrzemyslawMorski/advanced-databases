#!/bin/bash
sum_runtime=`awk "BEGIN {print 0; exit}"`
for i in $(seq 1 $NUM_TESTS) do
    start="date +%s%3N"
    output="$(psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -w -a -f /dvdrental/query.sql)"
    end=`date +%s%3N`
    runtime=`awk "BEGIN {print $end-$start; exit}"`
    echo $runtime
    sum_runtime=$(awk "BEGIN {print $sum_runtime+$runtime; exit}")
done
AVG_runtime=$(awk "BEGIN {print $sum_runtime/$NUM_TESTS; exit}")
echo "AVG_runtime - $AVG_runtime ms"