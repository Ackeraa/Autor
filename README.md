# Autor
The world has become so complicated that there are tons of information coming at me everyday. I fell so exhausted.

So I created this repository to help me gather all kinds of information that I'd like to see automatically(Autor).
And it will send me an email frequently(morning, noon, night, midnight). It contains:
* `diff.sh`: Get the diff file of today's last commit and first commit's parent commit of my repositories. 
* `diff2html.sh`: Used by `diff.sh` to convert .diff to .html, forked from https://gist.github.com/stopyoukid/5888146
* `horoscope.sh`: Get today's horoscope.
* `pocket.sh`: Get today's read-later list from https://getpocket.com.
* `rss.sh`: Get the RSS feed specified in `config/`.
* `weather.sh`: Get today's weather from https://wttr.in.
* `reporter.sh`: Combine all the above to generate the final report.


## Usage
### Create secrets in Settings -> Secrets -> Actions
* `LOCATION`: weather location
* `MAIL_USERNAME`: email user name
* `MAIL_PASSWORD`: email password
* `POCKET_CONSUMER_KEY`: used for Pocket 
* `POCKET_ACCESS_TOKEN`: used for Pocket
* `SIGN`: sign


### Custom files in `config/`
* `head`, `foot`: html layouts
* `morning`, `noon`, `night`, `midnight`: Config what to send at the time, add RSS link in `<rss>`, add script name in `<script>`

### Custom `.yml` file

* Change the time to send the email in `.github/workflows/main.ym`



With Autor, I don't bother to seek information everywhere. I just check my email whenever I like.

## TODO
* Add more interesting scripts
