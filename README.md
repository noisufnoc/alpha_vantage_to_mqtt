# Alpha Vantage to MQTT

This script was written to provide stock price to a MQTT sensor in the [HomeAssistant](https://home-assistant.io) home automation platform. Unfortunately the built in Alpha Vantage componet fails if you have more than 1 or 2 stocks that you want to follow. And this script also allows you to offload the sensor update to another system to save your [HomeAssistant](https://home-assistant.io) resources from non-mission critical functions.

## Requirements
* You will need the ability to execute this script.
* You will need a MQTT sever that you can publish to.
* You will need a Alpha Vantage API key which is free. Sign up at [https://www.alphavantage.co/support/#api-key](https://www.alphavantage.co/support/#api-key)
* if you want to use Splunk to log this script, jump to [You can Splunk it if you want to...](https://github.com/thejeffreystone/alpha_vantage_to_mqtt#you-can-splunk-it-if-you-want-to-you-can-leave-your-friends-behind) 

## Installation
* Install the app by cloning this repo
 - `git clone https://github.com/thejeffreystone/alpha_vantage_to_mqtt.git`
* Install the required python libraries:
 - `pip install paho-mqtt`
 - `pip install alpha_vantage`
 - `pip install python-dotenv`
* Edit the env-sample and saved as .env

## Run

This script is meant to run with something like supervisord, but can be executed manually and will stay running until killed.

There is a brief write up about the specific use case I built this for at [https://slackerlabs.org/2019/03/08/home-assistant-alpha-vantage/]

## Features
* This script publishes stock price to topic `stock/<stock_name>/price`
* This script utilizes the `get_batch_stock_quotes` method of the Alpha Vantage API to reduce the number of calls to the API to avoid hitting the API more than once a second.
* This script is built to run continiously and will pause for the interval set in the `.env` file.
* The script has an app_mode set in the .env file. When app_mode is set to `debug` the script will output status messages to stdout. If you would like to supress these, change app_mode to somethign other than `debug`. Default app_mode is `prod`.   
* Log the script to Splunk using Splunk's HTTP Event Collector

## You can Splunk It if you want to. You can leave your friends behind...

I added the ability to log to [Splunk's HTTP Event Collector](https://docs.splunk.com/Documentation/Splunk/latest/Data/UsetheHTTPEventCollector) if you are like me and like to Splunk everything. The script leverages [George Starcher's Python Class](https://github.com/georgestarcher/Splunk-Class-httpevent).

If you want to use the Splunk component you will need to install [George Starcher's Python Class](https://github.com/georgestarcher/Splunk-Class-httpevent)
 - `pip install git+git://github.com/georgestarcher/Splunk-Class-httpevent.git`

The update your .env to include the details of your Splunk server:
```
# Splunk Server:
splunk_host=192.168.1.20
# Splunk HEC Port - Default is 8088:
splunk_hec_port=8088
# Splunk Hec SSL:
splunk_hec_ssl=False
# Splunk HEC Token:
splunk_hec_key=

```
If you don't set a token, the script will ignore the Splunk portion. 

If you are knew to Splunk or the Splunk's HTTP Event Collector you can find more information at [Use Splunk's HTTP Event Collector](https://docs.splunk.com/Documentation/Splunk/latest/Data/UsetheHTTPEventCollector)

## Compatibility

This script was written and tested using python 3.7.2


