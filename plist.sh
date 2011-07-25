vname () { echo `diskutil cs info $1 | grep "Volume Name" | cut -d : -f 2 | sed -e 's/^\ *//'` ;} 
bool=false
# http://stackoverflow.com/questions/893585/how-to-parse-xml-in-bash#answer-2608159
rdom () { local IFS=\> ; read -d \< E C ;}
LVS=`diskutil cs list -plist`
echo $LVS | while rdom; do
    if [[ $E = string ]]; then
        echo "$C"
    fi
done | \
while read LINE
do
    if $bool
        then
            vname $LINE
    fi
    if [ $LINE = "LV" ]
        then
            bool=true
        else
            bool=false
    fi
done
