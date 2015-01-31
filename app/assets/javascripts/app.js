$(document).ready(function(){

  // This changes the dropdown for search in the navigation
  $('#search_menu_button').on('show.bs.dropdown', function () {
    console.log("Search is clicked");
    $('#all_search').click(function(ev) {
      console.log("All is clicked");
      $('#search_button_name').replaceWith("<span class= 'btn' id='search_button_name'>All <span class='caret'></span></span>");
    });
    $('#location_search').click(function(ev) {
      console.log("Location is clicked");
      $('#search_button_name').replaceWith("<span class= 'btn' id='search_button_name'>Location <span class='caret'></span></span><input id='search_type' name='search_type' type='hidden' value='location'>");
    });
    $('#person_search').click(function(ev) {
      console.log("Person is clicked");
      $('#search_button_name').replaceWith("<span class= 'btn' id='search_button_name'>Person <span class='caret'></span></span><input id='search_type' name='search_type' type='hidden' value='person'>");
    });
    $('#period_search').click(function(ev) {
      console.log("Time is clicked")
      $('#search_button_name').replaceWith("<span class= 'btn' id='search_button_name'>Time Period<span class='caret'></span></span><input id='search_type' name='search_type' type='hidden' value='period'>");
    });
    $('#keyword_search').click(function(ev) {
      console.log("Keyword is clicked")
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
            name: person.name
          };
        });
      }
    }
  });

  // Initialize the Bloodhound suggestion engine
  locations.initialize();
  people.initialize();


  // Instantiate the Typeahead UI
  $('#prefetch .typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 1},
    {
    name: 'locations',
    displayKey: 'name',
    minLength: 1,
    source: locations.ttAdapter(),
    templates: {
      header: '<h3 class="league-name">Locations</h3>'}
    },
    {
    name: 'people',
    displayKey: 'name',
    minLength: 1,
    source: people.ttAdapter(),
    templates: {
      header: '<h3 class="league-name">People</h3>'}
  });


  // bootstrapTags Inputs

  var pep = $('select');

  pep.tagsinput({
    itemValue: 'id',
    itemText: 'name',
    typeaheadjs: {
      name: 'locations',
      displayKey: 'name',
      source: locations.ttAdapter()
    }
  });

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
