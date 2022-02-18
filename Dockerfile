FROM ubuntu:latest
WORKDIR /usr/local/welcome-home

SHELL [ "bash", "-c" ]
# Set node into production mode
RUN echo export NODE_ENV=production >> ~/.bash_profile
RUN source ~/.bash_profile
# Install nodejs 17.x
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_17.x | bash -
RUN apt-get install -y nodejs git
RUN npm install -g yarn

# Prepare and build the app
RUN mkdir src
RUN mkdir app

RUN git clone https://github.com/LucasionGS/welcome-home.git src/welcome-home
RUN git clone https://github.com/LucasionGS/welcome-home-api.git src/welcome-home-api

RUN cd ./src/welcome-home && yarn install && yarn build
RUN cd ./src/welcome-home-api && npm install && npm run build

RUN cp -a src/welcome-home-api/dist app/dist
RUN cp -a src/welcome-home-api/node_modules app/node_modules
RUN cp src/welcome-home-api/package.json app/package.json
RUN cp -a src/welcome-home/build app/public

# Remove the src folder
RUN rm -rf src

EXPOSE 4321

CMD [ "node", "app/dist/index.js" ]