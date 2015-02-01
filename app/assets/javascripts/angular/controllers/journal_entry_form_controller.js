var app = angular.module('raisechange');

app.controller('JournalEntryFormCtrl', ['$scope', function($scope) {
  $scope.freeTextDates = false
  $scope.formats = ['dd-MMMM-yyyy', 'yyyy/MM/dd', 'dd.MM.yyyy', 'shortDate'];
  $scope.format = $scope.formats[0];
  dateSetup()

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
  }

  $scope.submitForm = function() {
    $(".submit-journal-entry").attr("disabled")
    var $form = $(".new_journal_entry");
    $form.append($('<input type="hidden" name="journal_entry[dates]" />').val(datesToSend()));
    $form.get(0).submit();
  };

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
}]);