# unanimity

A `nano` sync for `Backbone.js`, sampe use:

## installation

`npm install unanimity`

## usage

```
var nano = require('nano')('http://localhost:5984/')
  , backbone = require('backbone')
  , unanimity = require('unanimity')
  ;

var db = nano.use('test');

// bind the database to backbone
unanimity(backbone, db)

// Model id is the document id
user = new backbone.Model(id: 'user:john.doe')

// Fetch data
user.fetch({
  success: function(){
    console.log(user.toJSON());
  }
});
```

Syntax is fully compatible with original Backbone.js save/fetch.
