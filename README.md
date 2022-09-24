# Autor
The world has become so complicated that there are tons of information coming at me everyday. I fell so exhausted.

So I created this repository to help me gather all kinds of information that I'd like to see automatically(Autor).
And it will send me an email frequently(morning, noon, night, midnight). It contains:
* `diff.sh`: Get the diff file of today's last commit and first commit's parent commit of my repositories. 
* `diff2html.sh`: Used by `diff.sh` to convert .diff to .html, forked from [here](https://gist.github.com/stopyoukid/5888146)
* `horoscope.sh`: Get today's horoscope.
* `pocket.sh`: Get today's read-later list from [Pocket](https://getpocket.com).
* `rss.sh`: Get the RSS feed specified in `config/`.
* `weather.sh`: Get today's weather from [wttr](https://wttr.in).
* `wordnik.sh`: Get word of the day from [wordnik](https://wordnik.com).
* `reporter.sh`: Combine all the above to generate the final report.


With Autor, I don't bother to seek information everywhere. I just check my email whenever I like.

## Usage
### Create secrets in Settings -> Secrets -> Actions
* `GITHAB_USERNAME`: github username
* `LOCATION`: weather location
* `MAIL_USERNAME`: email user name
* `MAIL_PASSWORD`: email password
* `POCKET_CONSUMER_KEY`: used for Pocket 
* `POCKET_ACCESS_TOKEN`: used for Pocket
* `WORDNIK_KEY`: used for Wordnik
* `SIGN`: sign


### Custom files in `config/`
* `head`, `foot`: html layouts
* `profile.xml`: Config what to send at the `morning, noon, night, midnight`, add RSS link in `<rss>`, add script name in `<script>`

### Custom `.yml` file

* Option 1: Use `schedule` to trigger the workflow. Change the time to send the email in `.github/workflows/schedule.yml`, but it always has a delay.


* Option 2: Use `workflow_dispatch` to trigger the workflow. Use Github REST API, follow this [link](https://docs.github.com/en/rest/actions/workflows#create-a-workflow-dispatch-event). I use this one, just create 4 automatic jobs using iphone shortcut, and send an api request at sepcific time.

## TODO
* Add a blacklist of repo that I don't want to track
* Add more interesting scripts
