ChromeStats
=========
### for Linux/Mac

ChromeStats collects total user install counts for your Chrome extension in the Google Chrome store.

ChromeStats works by reading the total number of installs for your extension and saving the count to a Mongo database. Each entry includes a date/time stamp and total install count. Run the script at startup, collect data over time, and watch your total user count grow (or decline :O) over time.

Example Output
---

```javascript
{ 'Url': 'https://chrome.google.com/webstore/detail/your-app-name/abcdefghijklmnopqrstuvwxyz?hl=en', 'EventDate': ISODate('2014-09-29T22:59:56Z'), 'Users': 25621 }
```

Install
---

1. Download [chromestats.sh](https://raw.githubusercontent.com/primaryobjects/chromestats/master/chromestats.sh) and place it in a folder, such as ~/Documents/chromestats.

2. Edit the file and fill in values for the following variables at the top:

 ```sh
 # User-defined variables.
 appId="your-app-name/chrome-store-app-id"
 host="host.mongo.com:12345/dbname"
 user="mongo-username"
 pass="mongo-password"
 ```

3. Save the file and run it with:
 ```sh
 cd ~/Documents/chromestats
 bash chromestats.sh
 ```

The script will collect your total user install count and save it to your mongo database, using the collection name "analytics".

Running at Startup
---

You can automatically run the script at boot time by editing /etc/rc.local and adding an entry to run the script. It's a good idea to include logging of the output, so you know it's working.

1. Edit /etc/rc.local and add the following lines towards the top of the file:
 ```sh
 # Log rc.local to tmp/rc.local.log
 exec 2> /tmp/rc.local.log      # send stderr from rc.local to a log file
 exec 1>&2                      # send stdout to the same log file
 set -x
 
 bash "/home/username/Documents/chromestats/chromestats.sh"
 ```

License
----

MIT

Author
----
Kory Becker
http://www.primaryobjects.com/kory-becker
