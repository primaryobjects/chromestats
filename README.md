ChromeStats
=========
### for Linux


ChromeStats saves the daily total-user install count for your Chrome extension in the Google Chrome store. While the Chrome developer dashboard displays weekly user install counts, ChromeStats records the total user install count for all users currently using your extension.

ChromeStats works by reading the total number of installs for your extension and saving the count to a Mongo database. Each entry includes a date/time stamp and total install count.

ChromeStats makes it easy to automate the collection of total installs for your Chrome extension. Run the script at startup, collect data for a weeks or months, and chart the results! Watch your total user count grow (or decline :O) over time.

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

License
----

MIT

Author
----
Kory Becker
http://www.primaryobjects.com/kory-becker
