FROM eclipse-temurin:8-jdk-alpine

ARG PT_VERSION=2.5.32
ENV PT_VERSION ${PT_VERSION}

RUN mkdir -p /app/

# install tools
RUN apk update && apk add unzip curl 

# install nodejs
RUN apk add --update nodejs npm
RUN npm install pm2@latest -g

# install profittrailer
RUN curl https://github.com/taniman/profit-trailer/releases/download/$PT_VERSION/ProfitTrailer-$PT_VERSION.zip -L -o /app/profittrailer.zip
RUN unzip /app/profittrailer.zip -d /app/ && mv /app/ProfitTrailer-$PT_VERSION /app/ProfitTrailer

WORKDIR /app/ProfitTrailer
RUN chmod +x ProfitTrailer.jar

VOLUME /app/ProfitTrailer

CMD pm2 start pm2-ProfitTrailer.json && pm2 log 0

EXPOSE 8081
