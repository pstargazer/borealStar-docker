SRV_PATH=$CMD_PATH
cd ${SRV_PATH} 

npm i

if [ -d ./node_modules ]; then
    echo "deps is okay"
else
    npm install 
fi

npm run start