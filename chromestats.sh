# User-defined variables.
appId="your-app-name/chrome-store-app-id"
host="host.mongo.com:12345/dbname"
user=""
pass=""

# Internal variables.
regEx="title=\"([0-9,]+) users\""
url="https://chrome.google.com/webstore/detail/$appId?hl=en"
connectionString="$host -u $user -p $pass"
isOnline=0
connectionCount=0

echo "ChromeStats v1.0"

while [ $isOnline = 0 ] && (( $connectionCount < 10 ))
do
    # Check if we're online by pinging.
    isOnline=$(ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null && echo 1 || echo 0)

    if [ $isOnline = 0 ]
    then
        # Sleep and try again.
        sleep 20

        connectionCount=$(( connectionCount = connectionCount + 1 ))

        echo "Waiting for internet access ($connectionCount)."
    fi
done

if [ $isOnline = 1 ]
then
    # Download web page.
    content=$(wget $url -q -O -)

    # Scrape user count from Chrome extension page.
    if [[ $content =~ $regEx ]]
    then
        # Get regular expression match result.
        count=${BASH_REMATCH[1]}

        # Convert the string to an integer.
        count=${count//[!0-9]/}

        # Create json document.
        currentDate=`date -u +"%Y-%m-%dT%H:%M:%SZ"`
        document="{ 'Url': '$url', 'EventDate': ISODate('$currentDate'), 'Users': $count }"

        # Insert the document into mongo.
        mongo $connectionString --eval "db.analytics.insert($document)"

        echo $document
    else
        echo "Error: User count not found on Chrome extension page."
    fi
else
    echo "Error: No internet access available."
fi