exports.views = {
  showDocs: {
    map: function(doc) {
      emit(JSON.stringify(doc), null);
    }
  }
};
