var app = angular.module('raisechange');

app.controller('CampaignFormCtrl', ['$scope', 'ImageSelect', 'ToolTip', 'HoursInput', function($scope, ImageSelect, ToolTip, HoursInput) {
  $("#campaign_organization_name").addClass("form-control")

  $("#campaign_organization_name").on('autocompleteresponse', function(event, ui) {
    var content;
    if (((content = ui.content) != null ? content[0].id.length : void 0) === 0) {
      $(this).autocomplete('close');
    }
  });

  ToolTip.initialize()

  $scope.hours = parseInt($(".campaign-form-holder").attr("data-estimated-hours")) || 5;

  ImageSelect.fileNameFeedback()

  $('body').on('click', '.submit-button', function(e) {
    if (!$(this).is(":disabled")) {
      $(".campaign-form").submit()
    }
    $(this).attr("disabled", "disabled")
  });

  $scope.addHour = function() {
    if (parseInt($scope.hours) < HoursInput.maxHours()) { // Max hours, depending on the frequency
      $scope.hours = parseInt($scope.hours) + 1;
    }
  }

  $scope.subtractHour = function() {
    if (parseInt($scope.hours) > 1) {
      $scope.hours = parseInt($scope.hours) - 1;
    }
  }

  HoursInput.preventManualInputCheating($scope)
}]);