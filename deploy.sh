mkdir src
mkdir app

git clone https://github.com/LucasionGS/welcome-home.git src/welcome-home
git clone https://github.com/LucasionGS/welcome-home-api.git src/welcome-home-api

cd src/welcome-home
yarn install
yarn build

cd ../welcome-home-api
npm install
npm run build

cd ../..

cp -a src/welcome-home-api/dist app/dist
cp -a src/welcome-home-api/node_modules app/node_modules
cp src/welcome-home-api/package.json app/package.json
cp -a src/welcome-home/build app/public

rm -rf src

echo "Deployed!"
echo "Run with 'npm start'"