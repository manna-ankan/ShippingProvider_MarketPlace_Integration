// Mongo insert helper for marketplace Source document.
// Paste the filled source.json object. Do NOT run against production automatically.
//
// Usage (manual, review first):
//   use <mongo_db_name>;
//   load('db.js');   // or paste contents
//
// Replace the entire document below after filling templates/source.json.tpl.

db.source.insert({{SOURCE_JSON_OBJECT}});

print('Inserted source {{SOURCE_CODE}}. Refresh SourceConfiguration cache before testing.');
