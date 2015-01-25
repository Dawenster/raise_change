var app = angular.module('raisechange.controllers', []);

app.controller('UpdateUserCtrl', ['$scope', "CreditCards", function($scope, CreditCards) {
  $scope.showCreditCard = false;
  $scope.showPassword = false;
  $scope.showCancelAccount = false;

  $scope.makeDonation = CreditCards.makeDonation

  $scope.splitDate = function() {
    var dates = CreditCards.splitDate($scope.expiryDate)
    if (dates) {
      $scope.month = dates.month
      $scope.year = dates.year
    }
  }
}]);