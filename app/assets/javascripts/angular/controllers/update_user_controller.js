angular.module('raisechange', ['raisechange.controllers'])

var app = angular.module('raisechange.controllers', []);

app.controller('UpdateUserCtrl', ['$scope', function($scope) {
  $scope.showPassword = false;
}]);