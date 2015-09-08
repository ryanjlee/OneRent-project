# OneRent-project

## Instructions

Install the command line tools

```sh
npm install -g coffee-react-transform
```

Then translate the cjsx file to coffee to js

```sh
cjsx-transform src/oneRent.coffee | coffee -cs > client/oneRent.js
```

Then run the server
```sh
node server/server.js
```