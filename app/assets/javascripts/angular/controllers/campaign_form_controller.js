var app = angular.module('raisechange');

app.controller('CampaignFormCtrl', ['$scope', function($scope) {
  initialWebsiteLinkText();
  initialValidationSectionText();

  $scope.websiteLinkToggle = function() {
    $scope.websiteField = !$scope.websiteField;
    if ($scope.websiteField) {
      $scope.websiteFieldText = "Remove website";
    } else {
      $("#organization_website").val("");
      initialWebsiteLinkText()
    }
  }

  $scope.validationSectionToggle = function() {
    $scope.validationSection = !$scope.validationSection;
    if ($scope.validationSection) {
      $scope.validationSectionText = "Remove validator";
    } else {
      $("#organization_contacts_attributes_0_name").val("");
      $("#organization_contacts_attributes_0_email").val("");
      initialValidationSectionText()
    }
  }

  function initialWebsiteLinkText() {
    var pageType = $(".campaign-form").attr("data-page-type")
    if (pageType == "hasSite") {
      $scope.websiteField = true;
    } else {
      $scope.websiteField = false;
      $scope.websiteFieldText = "Add website (optional)";
    }
  }

  function initialValidationSectionText() {
    var pageType = $(".organization-validation-form-section").attr("data-page-type")
    if (pageType == "hasContact") {
      $scope.validationSection = true;
    } else {
      $scope.validationSection = false;
      $scope.validationSectionText = "Add validator (optional)";
    }
  }
}]);