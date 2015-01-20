$(document).ready(function(){
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

});
