exports.views =
  byCollection:
    map: (doc) ->
      # Adapt our data schema to backbone-couchdb lib by
      # reusing `type` field as collection identifier:
      doc.collection = doc.type
      emit(doc.type, doc)

  rfidScansByCreatedAtDesc:
    map: (doc) ->
      if doc.type == 'rfid-scan'
        if doc.created_at
          emit(-Date.parse(doc.created_at), doc)
        else
          emit(0, doc)

exports.filters =
  by_collection: (doc, req) ->
    # Adapt our data schema to backbone-couchdb lib by
    # reusing `type` field as collection identifier:
    if doc.type && req.query && req.query.collection && doc.type == req.query.collection
      true
    else if req.query && req.query.collection && doc._deleted
      true
    else
      false
