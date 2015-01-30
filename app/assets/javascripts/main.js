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
            name: location.name
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
  $('#locationInputForm').tagsinput({
    typeaheadjs: {
      name: 'locations',
      displayKey: 'name',
      source: locations.ttAdapter()
    }
  });



  $('#peopleInputForm').tagsinput({
    typeaheadjs: {
      name: 'people',
      displayKey: 'name',
      source: people.ttAdapter()
    }
  });



});
