# http://stackoverflow.com/questions/893585/how-to-parse-xml-in-bash#answer-2608159
rdom () { local IFS=\> ; read -d \< E C ;}
while rdom; do
    if [[ $E = string ]]; then
        echo $C
    fi
done < `diskutil cs list -plist`
