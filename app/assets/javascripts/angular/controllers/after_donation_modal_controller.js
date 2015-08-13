var app = angular.module('raisechange');

app.controller('AfterDonationModalCtrl', ['$scope', function($scope) {
  $scope.submitMessage = function() {
    if ($("textarea.add-message").val() != "") {
      $('#add-message').submit();
    }
  }
}]);