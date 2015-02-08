var app = angular.module('raisechange');

app.controller('AboutCtrl', ['$scope', function($scope) {
  hideAllWords()

  $scope.rollOverWord = function($event) {
    var word = $($event.target).attr("data-word")
    if (word == "record") {
      $scope.showRecord = true
    } else if (word == "influence") {
      $scope.showInfluence = true
    } else {
      $scope.showCommunicate = true
    }
  }

  $scope.hideWordTexts = function() {
    hideAllWords()
  }

  function hideAllWords() {
    $scope.showRecord = false
    $scope.showInfluence = false
    $scope.showCommunicate = false
  }
}]);