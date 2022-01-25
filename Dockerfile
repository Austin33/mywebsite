#The first instruction is what image we want to base our container on.
#We Use an official Python runtime as a parent image.

FROM python:3.8

#The environment variable ensures that the python output is set straight
#to the terminal with out buggering it first.

ENV PYTHONUNBUFFERED 1

RUN mkdir /austinlynum

WORKDIR /austinlynum

ADD . /austinlynum/

RUN pip install -r requirements.txt