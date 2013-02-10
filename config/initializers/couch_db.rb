require 'json'
require 'json/ext'
JSON.parser = JSON::Ext::Parser

require 'couchrest'

config = YAML.load(Rails.root.join('config/couchdb.yml').read)
url_root = ENV['CLOUDANT_URL'] || ENV['COUCH_DB_URL'] || config[Rails.env]['url']
database = ENV['COUCH_DATABASE_NAME'] || config[Rails.env]['database']

if url_root && database
  $db = CouchRest.database!(url_root + '/' + database)
else
  Rails.logger.info("Skipping CouchDB initialization since no config present")
end
