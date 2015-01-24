var app = angular.module('raisechange');

app.controller('CampaignFormCtrl', ['$scope', function($scope) {
  initialWebsiteLinkText();

  $scope.websiteLinkToggle = function() {
    $scope.websiteField = !$scope.websiteField;
    if ($scope.websiteField) {
      $scope.websiteFieldText = "Remove website";
    } else {
      $("#organization_website").val("");
      initialWebsiteLinkText()
    }
  }

  function initialWebsiteLinkText() {
    var pageType = $(".open-website-form-link").attr("data-page-type")
    if (pageType == "hasSite") {
      $scope.websiteField = true;
      $scope.websiteFieldText = "Edit website (optional)";
    } else {
      $scope.websiteField = false;
      $scope.websiteFieldText = "Add website (optional)";
    }
  }
}]);