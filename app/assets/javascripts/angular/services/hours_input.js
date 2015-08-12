var app = angular.module('raisechange.services');

app.factory("HoursInput", function() {
  var HoursInput = {};

  HoursInput.preventManualInputCheating = function($scope) {
    $(".custom-hours-input").blur(function() {
      if (parseInt($scope.hours) > HoursInput.maxHours()) {
        $scope.hours = HoursInput.maxHours()
        if(!$scope.$$phase) {
          $scope.$apply()
        }
      }
    })
  }

  HoursInput.maxHours = function() {
    var days = 31
    if ($(".weekly-button").hasClass("active")) {
      days = 7
    }
    return 24 * days
  }

  return HoursInput;
});