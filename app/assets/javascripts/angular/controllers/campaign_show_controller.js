var app = angular.module('raisechange');

app.controller('CampaignShowCtrl', ['$scope', function($scope) {
  $(function () {
    $('[data-toggle="popover"]').popover()
  })

  if ($.cookie('just_donated') == "true") {
    $('#after-donation-modal').modal("show");
    $.cookie('just_donated', false, { path: '/' });
  }
}]);