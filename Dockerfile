FROM python:3.8.1-slim
ARG packages
RUN apt update && apt upgrade -y && apt install ${packages} -y

RUN curl --silent https://bootstrap.pypa.io/get-pip.py | python3
RUN pip3 install pipenv

# -- Install Application into container:
RUN set -ex && mkdir /app

WORKDIR /app

# -- Adding Pipfiles
ONBUILD COPY Pipfile Pipfile
ONBUILD COPY Pipfile.lock Pipfile.lock

# -- Install dependencies:
ONBUILD RUN set -ex && pipenv install --deploy --system