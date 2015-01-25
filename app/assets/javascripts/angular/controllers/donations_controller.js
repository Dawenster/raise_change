var app = angular.module('raisechange');

app.controller('DonationCtrl', ['$scope', "CreditCards", function($scope, CreditCards) {
  $scope.makeDonation = CreditCards.makeDonation

  $scope.splitDate = function() {
    var dates = CreditCards.splitDate($scope.expiryDate)
    if (dates) {
      $scope.month = dates.month
      $scope.year = dates.year
    }
  }
}]);