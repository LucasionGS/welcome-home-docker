# Pull latest git repos
bash -c "cd ./src/ui && git pull"
bash -c "cd ./src/api && git pull"

# Build the project
bash -c "cd ./src/ui && yarn install && yarn build"
bash -c "cd ./src/api && npm install && npm run build"