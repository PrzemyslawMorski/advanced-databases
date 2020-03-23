#!/bin/bash

SUM_EXECUTION_TIME=$(awk "BEGIN {print 0.0; exit}")
SUM_PLANNING_TIME=$(awk "BEGIN {print 0.0; exit}")

counter=0
while [ $counter -lt $NUM_TESTS ]
do
    OUTPUT="$(psql -h dvd_rental_db -p 5432 -U postgres -d dvdrental -w -a -f /dvdrental/query.sql)"
    
    EXECUTION_TIME="$(echo $OUTPUT | grep -o -e 'Execution Time: \S* ms' | grep -o -e '[0-9]*[.][0-9]*')"
    PLANNING_TIME="$(echo $OUTPUT | grep -o -e 'Planning Time: \S* ms' | grep -o -e '[0-9]*[.][0-9]*')"
    
    if [ -n "$EXECUTION_TIME" ]; then
        if [ -n "$EXECUTION_TIME" ]; then
            SUM_EXECUTION_TIME=$(awk "BEGIN {print $SUM_EXECUTION_TIME+$EXECUTION_TIME; exit}")
            SUM_PLANNING_TIME=$(awk "BEGIN {print $SUM_PLANNING_TIME+$PLANNING_TIME; exit}")
            counter=$(( $counter + 1 ))
        fi
    fi
done

AVG_EXECUTION_TIME=$(awk "BEGIN {print $SUM_EXECUTION_TIME/$NUM_TESTS; exit}")
AVG_PLANNING_TIME=$(awk "BEGIN {print $SUM_PLANNING_TIME/$NUM_TESTS; exit}")

echo "AVG_EXECUTION_TIME - $AVG_EXECUTION_TIME ms"
echo "AVG_PLANNING_TIME - $AVG_PLANNING_TIME ms"

exit 0