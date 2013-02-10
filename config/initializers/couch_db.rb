require 'json'
require 'json/ext'
JSON.parser = JSON::Ext::Parser

require 'couchrest'

config = YAML.load(Rails.root.join('config/couchdb.yml').read)
couch_db_url = ENV['CLOUDANT_URL'] || ENV['COUCH_DB_URL'] || config[Rails.env]
if couch_db_url
  $db = CouchRest.database!(couch_db_url)
else
  Rails.logger.info("Skipping CouchDB initialization since no config present")
end
