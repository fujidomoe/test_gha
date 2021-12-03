FROM python:3.9.7-buster

ARG pipenv_install_option="--system"
ARG TAM_ENV

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN set -eux; \
  apt-get update \
  && apt-get install -y --no-install-recommends \
    vim \
    make \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*


RUN pip3 install pipenv
WORKDIR /opt/gha

ENV GHA_ENV $GHA_ENV
ENV PYTHONPATH /opt/gha

COPY ./Pipfile ./
COPY ./Pipfile.lock .
RUN pipenv install $pipenv_install_option

COPY ./app_py ./app_py
ENTRYPOINT ["/usr/bin/make", "-C", "app_py"]
CMD ["bash"]
