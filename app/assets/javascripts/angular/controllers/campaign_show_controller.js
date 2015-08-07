var app = angular.module('raisechange');

app.controller('CampaignShowCtrl', ['$scope', 'Popover', function($scope, Popover) {
  Popover.initialize()

  if ($.cookie('just_donated') == "true") {
    $('#after-donation-modal').modal("show");
    $.cookie('just_donated', false, { path: '/' });
  }
}]);