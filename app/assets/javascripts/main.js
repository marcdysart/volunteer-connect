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
      $('#search_button_name').replaceWith("<span class= 'btn' id='search_button_name'>Location <span class='caret'></span></span>");
    });
    $('#time_search').click(function(ev) {
      console.log("Time is clicked")
      $('#search_button_name').replaceWith("<span class= 'btn' id='search_button_name'>Time <span class='caret'></span></span>");
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
      url: '../locations/1.json',
      filter: function (list) {
        // Map the remote source JSON array to a JavaScript object array
        return $.map(list, function (location) {
          return {
            name: location.name
          };
        });
      }
    }
  });

  // Initialize the Bloodhound suggestion engine
  locations.initialize();


  // Instantiate the Typeahead UI
  $('#prefetch .typeahead').typeahead(null, {
    displayKey: 'name',
    source: locations.ttAdapter(),
    templates: {
      header: '<h3 class="league-name">Locations</h3>'
    }
  });
});
