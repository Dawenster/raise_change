var app = angular.module('raisechange');

app.controller('LandingCtrl', 'ToolTip', ['$scope', function($scope, ToolTip) {
  ToolTip.initialize()
}]);