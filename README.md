Bartender: The CouchApp
========================

Let's try this out.


Installation
-------------------

* Get a couchdb running on <http://localhost:5984>:

    brew install couchdb
    couchdb

* Install node and npm:

    brew install node

* Install [kanso](http://kan.so):

    npm install -g kanso

* Install dependencies:

    kanso install

* Deploy to the database name of your choice, I use `radio_beer_development`:

    kanso push radio_beer_development

User stories
-------------------

* As a bartender, I want to:
  * list a new beer
  * & edit existing beers
  * list a new tap
  * & edit existing taps
  * associate a tap with an rfid-reader over a timespan
  * indicate that I tapped a beer on a particular tap at a particular time
  * indicate when that tap ran out

Related app user stories
--------------------------

* App: Registration kiosk:
  * As a user, I want to:
    * claim a Glass with my name
    * optionally add my email
    * optionally add my photo

* As the system, I want to:
  * aggregate RfidScanEvents against Tappings and Glasses and Users to
  * produce PourEvents:

```
rfid-scan:
  reader_id
  tag_id

tapping:
  tap_id
  beer_id
  started_at
  finished_at

tap:
  rfid_reader_id

glasses:
  user_id
  tag_id

client-side view function on rfid-scan-event to synthesize pour-event:
  with rfid-scan-event
    glass = rfid-scan-event.tag_id -> glasses.tag_id
    beer  = rfid-scan-event.reader_id -> tap(rfid_reader_id) -> tapping(tap_id) -> beer
  emit <glass, beer>
```


Schema Notes
---------------------

```
Bar
  type: bar
  created_at
  name
  has_many Taps

Tap
  type: tap
  name
  rfid_reader_id

Tapping
  type: tapping
  tap_id
  beer_id
  started_at
  finished_at

Beer
  type: beer
  name
  style
  abv_percent

RfidReader
  type: rfid-reader
  name

RfidScanEvent
  type: rfid-scan
  created_at
  tag_id

Glass
  type: glass
  tag_id
  nickname

Pour
  mapreduce view
  map RfidScanEvent<rfid_reader, tag_reader>

User
  name
  email
  photo
  has_many Glasses

Bartendings
  bar_id
  user_id
```

tech notes
--------------

tech notes
possible configs w rainbows on heroku
  http://rubyforge.org/pipermail/rainbows-talk/2012-June/thread.html#355

http://support.cloudant.com/customer/portal/articles/359321-how-do-i-read-and-write-to-my-cloudant-database-from-the-browser-

gardener: external node processes for couchapps
  https://github.com/garden20/gardener

possible approach to async aggregate view producer:
  changes + gardener?
  http://guide.couchdb.org/draft/notifications.html

distributed app store thing?
  http://garden20.com/

discussions of schematization, lazy gardening
  http://fourkitchens.com/blog/2009/07/05/how-schema-got-bad-name
  http://fourkitchens.com/blog/2010/02/21/cap-theorem-physics-airplanes-every-database-must-design-around-it
