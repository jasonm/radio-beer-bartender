exports.views =
  showDocs:
    map: (doc) ->
      emit(JSON.stringify(doc), null)
