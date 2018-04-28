// Get references to the tbody element, input field and button
var $tbody = document.querySelector("tbody");
var $stateInput = document.querySelector("#state");
var $searchBtn = document.querySelector("#search");

// Add an event listener to the searchButton, call handleSearchButtonClick when clicked
$searchBtn.addEventListener("click", handleSearchButtonClick);

// Set sightings to data initially
var sightings = dataSet;

// renderTable renders the sightings to the tbody
function renderTable() {
  $tbody.innerHTML = "";
  for (var i = 0; i < sightings.length; i++) {
    // Get get the current datetime object and its fields
    var datetime = sightings[i];
    var fields = Object.keys(datetime);
    // Create a new row in the tbody, set the index to be i + startingIndex
    var $row = $tbody.insertRow(i);
    for (var j = 0; j < fields.length; j++) {
      // For every field in the datetime object, create a new cell at set its inner text to be the current value at the current datetime's field
      var field = fields[j];
      var $cell = $row.insertCell(j);
      $cell.innerText = datetime[field];
    }
  }
}

function handleSearchButtonClick() {
  // Format the user's search by removing leading and trailing whitespace, lowercase the string
  var filterState = $stateInput.value.trim().toLowerCase();

  // Set sightings to an array of all datetimees whose "state" matches the filter
  sightings = dataSet.filter(function(datetime) {
    var datetimeState = datetime.datetime;

    // If true, add the datetime to the sightings, otherwise don't add it to sightings
    return datetimeState === filterState;
  });
  renderTable();
}

// Render the table for the first time on page load
renderTable();