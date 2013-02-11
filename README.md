Bartender: The CouchApp
========================

Let's try this out.


Prerequisites
-------------

Get couchdb:

```
brew install couchdb
```

Install node and npm:

```
brew install node
```

Install [kanso](http://kan.so):

```
npm install -g kanso
```

Install rubygem dependencies:

```
gem install sass foreman watchr ruby-fsevent # Mac OSX
gem install sass foreman watchr rev          # Linux/BSD
```

Installation
------------

Install dependencies:

```
kanso install
```

Specify the name of the local (and, optionally, production) database you want
to deploy to:

```
cp kansorc.example .kansorc
```

Now, edit `.kansorc` to change the local or production database.

Deploy:

```
kanso push
```

You should see output ending with something like:

```
Build complete: 131ms
Uploading...
OK: http://localhost:5984/radio_beer_development/_design/bartender/index.html
```

Open that URL to view the app.


Development
-------------

As you develop, automatically rebuild SCSS files with `sass` and the Kanso site
with `watchr`:

```
foreman start
```

If couch isn't already running, it'll get run, too.

Edit `index.html`, `lib/**/*.js`, and `static/scss/*.scss` to make changes.


Deployment
-----------------

When you are ready to go live, make sure `.kansorc` has the correct credentials
under the `production` key, then push:

```
kanso push production
```

Notes
===================

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

Technical notes
===============

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

possibly introduce livereload to kanso via gardener:
  https://github.com/livereload/livereload-server
  https://github.com/kanso/kanso-gardener
  https://github.com/garden20/gardener

I needed to add `sass watch` as a separate process because ruby `sass` is too slow to start up.
  Go back to straight preprocessor with node-sass? https://github.com/andrew/node-sass

Then maybe all ruby deps can be removed:
  https://github.com/nodefly/node-foreman
