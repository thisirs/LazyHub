#! /bin/bash

# git update-ref -d HEAD
# git push --force origin master

read -r -d '' PATTERN <<'EOF'
0001001000
0011111100
0116116110
1111111111
1111111111
1010000101
0011001100
EOF

# Has to be a monday
START="13 oct 2013"
DAY=0
for LINE in $PATTERN; do
    echo $LINE
    for (( i=0; i<${#LINE}; i++ )); do
        DAYS=$(($DAY + 7*$i))
        DATE=$(LC_ALL=C date -d "$START +$DAYS days +12 hours")
        for (( j=0; j<${LINE:$i:1}; j++ )); do
            echo $DATE
            echo ${LINE:$i:1}
            echo 1 >> dummy
            git add -A > /dev/null 2>&1
            git commit --date="$DATE" -m "Day $DAYS, commit $j" > /dev/null 2>&1
        done
    done
    DAY=$((($DAY + 1) % 7))
done

# git push --force origin master
