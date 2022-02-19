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

RUN git clone https://github.com/LucasionGS/welcome-home.git src/ui
RUN git clone https://github.com/LucasionGS/welcome-home-api.git src/api

COPY update.sh .

# Update the repositories, install dependencies, and build them.
RUN chmod +x update.sh && ./update.sh

# Link up the frontend and backend
RUN ln -s `pwd`/src/ui/build src/api/public

# Updates should take effect immediately after restart.
# For updating it should
# - Pull repositories
# - Frontend: Run yarn install
# - Frontend: Run yarn build
# - Backend: Run npm install
# - Backend: Run npm run build
# Restart backend

EXPOSE 4321

CMD [ "node", "src/api/dist/index.js", "--docker" ]