FROM node:7-alpine

ENV VERSION 8ff3ad18d8eccf07d8f2a150de898be71affd42e

RUN apk add --no-cache --virtual .build-deps curl ca-certificates \
    && curl -fSL "https://github.com/golastmile/rasa-nlu-trainer/archive/${VERSION}.tar.gz" | tar -xzf - \
    && cd rasa-nlu-trainer-${VERSION} \
    && npm install --global rasa-nlu-trainer \
    && cd - \
    && rm -fr rasa-nlu-trainer-${VERSION} \
    && apk del .build-deps

WORKDIR /data
COPY training.json .

VOLUME /data
EXPOSE 8080

CMD ["rasa-nlu-trainer", "-p", "8080", "-s", "/data/training.json"]
