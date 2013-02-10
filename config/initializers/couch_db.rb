require 'json'
require 'json/ext'
JSON.parser = JSON::Ext::Parser

require 'couchrest'

config = YAML.load(Rails.root.join('config/couchdb.yml').read, safe: true)
couch_db_url = ENV['CLOUDANT_URL'] || ENV['COUCH_DB_URL'] || config[Rails.env]
$db = CouchRest.database!(couch_db_url)
