var app = angular.module('raisechange');

app.controller('JournalEntryFormCtrl', ['$scope', function($scope) {
  $scope.dateError = false
  $scope.hoursError = false
  $scope.freeTextDates = false
  $scope.showDescription = false

  $scope.descriptionButtonText = "Add description"
  $scope.pictureButtonText = "Add pictures"
  $scope.formats = ['dd-MMMM-yyyy', 'yyyy/MM/dd', 'dd.MM.yyyy', 'shortDate'];
  $scope.format = $scope.formats[0];
  $scope.hours = parseInt($(".journal-entry-form").attr("data-hours")) || 5;
  dateSetup()
  pictureSetup()
  descriptionSetup()

  $scope.today = function() {
    $scope.dt = new Date();
  };

  $scope.clear = function () {
    $scope.dt = null;
  };

  $scope.open = function($event) {
    $event.preventDefault();
    $event.stopPropagation();

    $(".free-text-field").val("")
    $scope.freeTextDates = false

    $scope.opened = true;
  };

  $scope.dateOptions = {
    formatYear: 'yy',
    startingDay: 1,
    showWeeks: false
  };

  $scope.enterFreeText = function() {
    $scope.dt = null;
    $scope.freeTextDates = !$scope.freeTextDates;
    $(".free-text-field").val("")
  }

  $scope.submitForm = function() {
    if (emptyDates()) {
      $scope.dateError = true
      $('html,body').scrollTop(0);
    } else {
      $(".submit-journal-entry").attr("disabled")
      $form = correctForm()
      $form.append($('<input type="hidden" name="journal_entry[dates]" />').val(datesToSend()));
      $form.get(0).submit();
    }
  };

  function correctForm() {
    if (isCreatePage()) {
      return $(".new_journal_entry");
    } else {
      return $(".edit_journal_entry");
    }
  }

  function isCreatePage() {
    var entryType = $(".journal-entry-form").attr("data-entry-type")
    return entryType == "create"
  }

  function dateSetup() {
    var existingDates = $(".journal-entry-date-selector").attr("data-existing-dates")
    if (existingDates) {
      if (isFromDatepicker(existingDates)) {
        $scope.dt = existingDates
      } else {
        $scope.freeTextDates = true
        $(".free-text-field").val(existingDates)
      }
    }
  }

  function isFromDatepicker(date) {
    return date.split("00:00:00 GMT").length > 1
  }

  function datesToSend() {
    var textFieldValue = $(".free-text-field").val()
    if (textFieldValue == "") {
      return $scope.dt
    } else {
      return textFieldValue
    }
  }

  function emptyDates() {
    return !$scope.dt && $(".free-text-field").val() == ""
  }

  $scope.addHour = function() {
    $scope.hours = parseInt($scope.hours) + 1;
  }

  $scope.subtractHour = function() {
    if (parseInt($scope.hours) > 1) {
      $scope.hours = parseInt($scope.hours) - 1;
    }
  }

  $scope.toggleDescription = function() {
    toggleDescription()
  }

  function toggleDescription() {
    $scope.showDescription = !$scope.showDescription
    if ($scope.showDescription) {
      $scope.descriptionButtonText = "Remove description"
    } else {
      $scope.descriptionButtonText = "Add description"
      $("#journal_entry_description").val("")
    }
  }

  $scope.togglePictures = function() {
    $scope.showPictures = !$scope.showPictures
    if ($scope.showPictures) {
      $scope.pictureButtonText = "Remove pictures"
    } else {
      $scope.pictureButtonText = "Add pictures"
      $(".fields").remove()
      $(".add_nested_fields").click()
    }
  }

  function pictureSetup() {
    var hasPictures = $(".journal-entry-form").attr("data-has-media")
    if (hasPictures == "true") {
      $scope.showPictures = true
    } else {
      $scope.showPictures = false
      if ($(".fields:visible").length == 0) {
        $(".add_nested_fields").click()
      }
    }
  }

  function descriptionSetup() {
    var hasDescription = $(".journal-entry-form").attr("data-has-description")
    if (hasDescription == "true") {
      toggleDescription();
    }
  }
}]);