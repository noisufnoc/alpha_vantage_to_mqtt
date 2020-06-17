FROM python:3
MAINTAINER Mike Walker <github@noisufnoc.com>

ADD alpha_vantage_to_mqtt.py /
ADD requirements.txt /

RUN pip install -r requirements.txt

CMD [ "python", "./alpha_vantage_to_mqtt.py" ]
