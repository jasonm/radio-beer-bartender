require 'json'
require 'json/ext'
JSON.parser = JSON::Ext::Parser

require 'couchrest'

config = YAML.load(Rails.root.join('config/couchdb.yml').read, safe: true)
$db = CouchRest.database!(config[Rails.env])
