var app = angular.module('raisechange');

app.controller('LandingCtrl', ['$scope', 'ToolTip', function($scope, ToolTip) {
  ToolTip.initialize()
}]);