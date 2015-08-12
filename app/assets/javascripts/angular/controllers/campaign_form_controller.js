var app = angular.module('raisechange');

app.controller('CampaignFormCtrl', ['$scope', 'ImageSelect', 'ToolTip', function($scope, ImageSelect, ToolTip) {
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
    if (parseInt($scope.hours) < (maxHours())) { // Max hours, depending on the frequency
      $scope.hours = parseInt($scope.hours) + 1;
    }
  }

  $scope.subtractHour = function() {
    if (parseInt($scope.hours) > 1) {
      $scope.hours = parseInt($scope.hours) - 1;
    }
  }

  $(".custom-hours-input").blur(function() {
    if (parseInt($scope.hours) > maxHours()) {
      $scope.hours = maxHours()
      if(!$scope.$$phase) {
        $scope.$apply()
      }
    }
  })

  function maxHours() {
    var days = 31
    if ($(".weekly-button").hasClass("active")) {
      days = 7
    }
    return 24 * days
  }
}]);