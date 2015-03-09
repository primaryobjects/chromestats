var request = require('request');
var MongoClient = require('mongodb').MongoClient;

// User-defined variables.
appId="your-app-name/chrome-store-app-id"
user=""
pass=""
host='mongodb://' + user + ':' + pass + '@host.mongo.com:12345/dbname';

// Internal variables.
regEx=/title=\"([0-9,]+) users\"/;
url='https://chrome.google.com/webstore/detail/' + appId + '?hl=en';

console.log('ChromeStats v1.1');

// Download web page.
request(url, function(err, response, body) {
    if (err || response.statusCode != 200) {
        console.log('Error downloading ' + url + '. Response code: ' + response.statusCode + ', Error: ' + err);
    }
    else {
        // Scrape user count from Chrome extension page.
        var count = body.match(regEx);
        if (count && count.length > 0) {
            count = count[1];

            // Convert the string to an integer.
            count = parseInt(count.replace(/,/g, ''));

            // Create json document.
            var document = { EventDate: new Date(), Users: count };

            // Insert the document into mongo.
            MongoClient.connect(host, function(err, db) {
                if (err) throw err;
                else {
                    // Insert records
                    db.collection('analytics').insert(document, function(err, records) {
                        if (err) throw err;
                        else {
                            db.close();
                            console.log(document);
                        }
                    });
                }
            });
        }
        else {
            console.log('Error: User count not found on Chrome extension page.');
        }
    }
});