FROM python:3.8.2-slim

ENV APP_HOME /app
WORKDIR ${APP_HOME}

COPY . ./

RUN apt-get update && apt-get install -y --no-install-recommends \
        tzdata \
        build-essential \
        libssl-dev \
        libpq-dev \
        libcurl4-gnutls-dev \
        libexpat1-dev \
        gettext \
        unzip \
        supervisor \
        python3-setuptools \
        python3-pip \
        python3-dev \
        python3-venv \
        python3-urllib3 \
        git \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Upgrade PIP
RUN pip install pip pipenv --upgrade

#Pycaret
RUN pip install pycaret[full] --use-deprecated=legacy-resolver


# Project installs
RUN pipenv install --skip-lock --system --dev


CMD ["./scripts/entrypoint.sh"]