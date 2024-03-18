const { readFileSync, writeFileSync } = require("fs");
const Handlebars = require("handlebars");

Handlebars.registerHelper("literal", function(value) {
  return new Handlebars.SafeString(`${value}`);
});

handlebarsTest();

function camelize(str) {
  return str.replace(/(?:^\w|[A-Z]|\b\w)/g, function(word, index) {
    return word.toUpperCase();
  }).replace(/-+/g, '');
}

// TODO: Generate BuildInfo.properties with version from OpenApi spec

function handlebarsTest(){
  const oas = readFileSync('./src/main/configurations/brp-personen-bevragen-client/openapi-haalcentraal-2.1.0.json', 'utf8');
  json = JSON.parse(oas);
  const adapterTemplateString = readFileSync('./tools/templating/brp-personen-bevragen-client/list-operation-sender-module.hbs', 'utf8');
  const adapterTemplate = Handlebars.compile(adapterTemplateString);

  var ctx = {};
  ctx["api"] = new String(json.info.title).replace(' ', '-').toLowerCase();

  for(const pathKey in json.paths){
    ctx["path"] = pathKey.replace('/', '').toLowerCase();
    for(const [key, value] of Object.entries(json.paths[pathKey])){
      var adapter = {};
      if(key === 'post'){
        console.log(value.operationId);
        adapter = buildListAdapter(value, ctx["api"], pathKey);

        //console.log(JSON.stringify(adapter, null, 4));
        ctx["adapter"] = adapter;
        var out = adapterTemplate(ctx)
        writeFileSync(`./src/main/configurations/brp-personen-bevragen-client/configuration-${adapter.name}.xml`, out);
      }

      
    }
  }
}

function buildListAdapter(ctx, api, path){
  var adapterName = `${api}-client-${ctx.tags}-${ctx.operationId}`;
  var adapter = {
    "collection": String(path).substring(String(path).lastIndexOf('/') + 1),
    "object-type": String(ctx.operationId).substring(0, String(ctx.operationId).indexOf('_')),
    "name": adapterName,
    "description": `${ctx.description}`
  };

  var params = buildParameters(ctx.parameters || []);
  adapter["sender"] = { 
    "name": camelize(`${ctx.tags}-${ctx.operationId}`),
    "params": params
  };

  return adapter;
}

function buildParameters(ctx, path = ''){
  var params = [];

  for(const parameter of ctx){
    if(parameter.in === 'query'){
      params.push({ 
        "name": new String(parameter.name),
        "description": new String(parameter.description)
      });
    }
  }

  return params;
}
