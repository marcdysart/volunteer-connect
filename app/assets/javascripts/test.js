$(document).ready(function(){

  var locationsData = [{"name":"Conakry","id":12},{"name":"Eleanoreland","id":3},{"name":"Erinborough","id":8},{"name":"Labe","id":11},{"name":"Lelouma","id":16},{"name":"Marianborough","id":2},{"name":"New Jerrodshire","id":5},{"name":"Port Larrychester","id":6},{"name":"Thelmabury","id":10},{"name":"Torphybury","id":4},{"name":"Vaughnview","id":7},{"name":"Welchmouth","id":13},{"name":"West Cassieland","id":9},{"name":"West Daisyfort","id":15},{"name":"West Gerhardville","id":1},{"name":"West Staceyfurt","id":14}]

  var testlocations = new Bloodhound({
    datumTokenizer: function (datum) {
      return Bloodhound.tokenizers.whitespace(datum.name);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    local: locationsData
  });

// Initialise Bloodhound suggestion engines for each input
testlocations.initialize();


// Make the code less verbose by creating variables for the following
var testlocationsTypeahead = $('#testlocation.typeahead');

// Initialise typeahead for the employee name
testlocationsTypeahead.typeahead({
    highlight: true,
  },{
    name: 'locations',
    displayKey: 'name',
    source: testlocations.ttAdapter()
  });

});
