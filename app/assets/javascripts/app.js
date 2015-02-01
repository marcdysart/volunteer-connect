$(document).ready(function(){

  // This changes the dropdown for search in the navigation
  $('#search_menu_button').on('show.bs.dropdown', function () {

    $('#all_search').click(function(ev) {

      $('#search_button_name').replaceWith("<span class= 'btn' id='search_button_name'>All <span class='caret'></span></span>");
    });
    $('#location_search').click(function(ev) {
      $('#search_button_name').replaceWith("<span class= 'btn' id='search_button_name'>Location <span class='caret'></span></span><input id='search_type' name='search_type' type='hidden' value='location'>");
      $( '#search_bar' ).parent().removeClass('close');
      $('#time_search_to').addClass('close');
      $('#time_search_from').addClass('close');
      $('#search_to_tag').addClass('close');
    });
    $('#person_search').click(function(ev) {
      $('#search_button_name').replaceWith("<span class= 'btn' id='search_button_name'>Person <span class='caret'></span></span><input id='search_type' name='search_type' type='hidden' value='person'>");
      $( '#search_bar' ).parent().removeClass('close');
      $('#time_search_to').addClass('close');
      $('#time_search_from').addClass('close');
      $('#search_to_tag').addClass('close');
    });
    $('#period_search').click(function(ev) {
      $('#search_button_name').replaceWith("<span class= 'btn' id='search_button_name'>Time Period<span class='caret'></span></span><input id='search_type' name='search_type' type='hidden' value='period'>");
      $( '#search_bar' ).parent().addClass('close');
      $('#time_search_to').removeClass('close');
      $('#time_search_from').removeClass('close');
      $('#search_to_tag').removeClass('close');

    });
    $('#keyword_search').click(function(ev) {
      $('#search_button_name').replaceWith("<span class= 'btn' id='search_button_name'>Keyword <span class='caret'></span></span>");
    });
  });

// This changes the dropdown for location
  $('#dropdownLocation').click(function () {
    console.log("Location Location is clicked");
    $('.dropdown-menu a').click(function(ev) {
      var item_id = $(this).attr('id');
      var item_name = $(this).text();
      $('#location_choice').replaceWith("<span id='location_choice'>"+item_name+"</span>");
    });
  });


//  Typeahead with Prefetch for Locations

  // Instantiate the Bloodhound suggestion engine
  var locations = new Bloodhound({
    datumTokenizer: function (datum) {
      return Bloodhound.tokenizers.whitespace(datum.name);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    limit: 10,
    remote: {
      url: '../locations.json',
      filter: function (list) {
        // Map the remote source JSON array to a JavaScript object array
        return $.map(list, function (location) {
          return {
            name: location.name,
            id: location.id
          };
        });
      }
    }
  });

  var people = new Bloodhound({
    datumTokenizer: function (datum) {
      return Bloodhound.tokenizers.whitespace(datum.name);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    limit: 10,
    remote: {
      url: '../people.json',
      filter: function (list) {
        // Map the remote source JSON array to a JavaScript object array
        return $.map(list, function (person) {
          return {
            name: person.name,
            id: person.id
          };
        });
      }
    }
  });

  var substringMatcher = function(strs) {
  return function findMatches(q, cb) {
    var matches, substrRegex;

    // an array that will be populated with substring matches
    matches = [];

    // regex used to determine if a string contains the substring `q`
    substrRegex = new RegExp(q, 'i');

    // iterate through the pool of strings and for any string that
    // contains the substring `q`, add it to the `matches` array
    $.each(strs, function(i, str) {
      if (substrRegex.test(str)) {
        // the typeahead jQuery plugin expects suggestions to a
        // JavaScript object, refer to typeahead docs for more info
        matches.push({ value: str });
      }
    });

    cb(matches);
  };
};
  var periods = ['1961', '1962', '1963', '1964', '1965', '1966', '1967', '1968', '1969',
  '1970', '1971', '1972', '1973', '1974', '1975', '1976', '1977', '1978', '1979',
  '1980', '1981', '1982', '1983', '1984', '1985', '1986', '1987', '1988', '1989',
  '1990','1991', '1992', '1993', '1994', '1995', '1996', '1997', '1998', '1999',
  '2000', '2001', '2002', '2003', '2004', '2005', '2006', '2007', '2008', '2009',
  '2010', '2011', '2012', '2013', '2014', '2015'];


  $('#time_search_to.typeahead').typeahead({
  hint: true,
  highlight: true,
  minLength: 1
},
{
  name: 'periods',
  displayKey: 'value',
  source: substringMatcher(periods)
});

$('#time_search_from.typeahead').typeahead({
hint: true,
highlight: true,
minLength: 1
},
{
name: 'periods',
displayKey: 'value',
source: substringMatcher(periods)
});

  // Initialize the Bloodhound suggestion engine
  locations.initialize();
  people.initialize();

  var locationsTypeahead = $('#prefetchlocation.typeahead');
  var peopleTypeahead = $('#prefetchpeople.typeahead');
  var searchTypeahead = $('#search_bar.typeahead');


  // Instantiate the Typeahead UI

  searchTypeahead.typeahead({
    highlight: true,
  },{
    name: 'locations',
    displayKey: 'name',
    source: locations.ttAdapter(),
    templates: {
      header: '<h3 class="league-name">Locations</h3>'}
  },
  {
    name: 'people',
    displayKey: 'name',
    source: people.ttAdapter(),
    templates: {
      header: '<h3 class="league-name">People</h3>'}
  });





  locationsTypeahead.typeahead({
    highlight: true,
  },{
    name: 'locations',
    displayKey: 'name',
    source: locations.ttAdapter()
  });

  peopleTypeahead.typeahead({
    highlight: true
  },{
    name: 'people',
    displayKey: 'name',
    source: people.ttAdapter()
  });

  var locationsItemSelectedHandler = function (eventObject, suggestionObject, suggestionDataset) {
      /* According to the documentation the following should work https://github.com/twitter/typeahead.js/blob/master/doc/jquery_typeahead.md#jquerytypeaheadval-val.
      However it causes the suggestion to appear which is not wanted */
      //employeeIdTypeahead.typeahead('val', suggestionObject.id);
      peopleTypeahead.val(suggestionObject.id);
  };

  var peopleItemSelectedHandler = function (eventObject, suggestionObject, suggestionDataset) {
      /* See comment in previous method */
      //employeeNameTypeahead.typeahead('val', suggestionObject.name);
      locationsTypeahead.val(suggestionObject.name);
  };

  // Associate the typeahead:selected event with the bespoke handler
  locationsTypeahead.on('typeahead:selected', locationsItemSelectedHandler);
  peopleTypeahead.on('typeahead:selected', peopleItemSelectedHandler);


  // bootstrapTags Inputs

  // var loc = $('select');
  //
  // loc.tagsinput({
  //   itemValue: 'id',
  //   itemText: 'name',
  //   typeaheadjs: {
  //     name: 'locations',
  //     displayKey: 'name',
  //     source: locations.ttAdapter()
  //   }
  // });

  var ser= $('input#search_bar')
  ser.tagsinput({
    itemValue: 'name',
    itemText: 'name',
    typeaheadjs: {
      name: 'locations',
      displayKey: 'name',
      source: locations.ttAdapter()
    }
  });

  // var pep = $('select');
  // pep.tagsinput({
  //   itemValue: 'id',
  //   itemText: 'name',
  //   typeaheadjs: {
  //     highlight: true,
  //     name: 'people',
  //     displayKey: 'name',
  //     source: people.ttAdapter()
  //   }
  // });



//Google Maps v3

// In the following example, markers appear when the user clicks on the map.
// The markers are stored in an array.
// The user can then click an option to hide, show or delete the markers.
var geocoder;
var map;
var markers = [];

function initialize() {
  geocoder = new google.maps.Geocoder();
  var conakryGuinea = new google.maps.LatLng(9.6355819,-13.5787382);
  var mapOptions = {
    zoom: 8,
    center: conakryGuinea,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  // This event listener will call addMarker() when the map is clicked.
  google.maps.event.addListener(map, 'click', function(event) {
    addMarker(event.latLng);
  });



  // Adds a marker at the center of the map.
  addMarker(conakryGuinea);
}

// Find address from search
function codeAddress() {
  var address = document.getElementById('address').value;
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

// Add a marker to the map and push to the array.
function addMarker(location) {
  var marker = new google.maps.Marker({
    position: location,
    map: map
  });
  markers.push(marker);
}

// Sets the map on all markers in the array.
function setAllMap(map) {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(map);
  }
}

// Removes the markers from the map, but keeps them in the array.
function clearMarkers() {
  setAllMap(null);
}

// Shows any markers currently in the array.
function showMarkers() {
  setAllMap(map);
}

// Deletes all markers in the array by removing references to them.
function deleteMarkers() {
  clearMarkers();
  markers = [];
}

google.maps.event.addDomListener(window, 'load', initialize);

$('#delete_markers').click(function () {
  deleteMarkers();
});
$('#find_location').click(function () {
  deleteMarkers();
  codeAddress();

});

});
