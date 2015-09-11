# OneRent-project

## Instructions

Install the bower components, node modules, and command line tools

```sh
bower install
npm install
npm install -g coffee-react-transform
```

Translate the cjsx file to coffee to js
(Latest compiled js file has been included for convenience)

```sh
cjsx-transform src/oneRent.coffee | coffee -cs > client/oneRent.js
```

Run the server
```sh
node server/server.js
```