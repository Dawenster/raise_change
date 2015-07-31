var app = angular.module('raisechange');

app.controller('CampaignFormCtrl', ['$scope', function($scope) {
  initialWebsiteLinkText();
  initialValidationSectionText();

  $(".organization-name-autocomplete").on('autocompleteresponse', function(event, ui) {
    var content;
    if (((content = ui.content) != null ? content[0].id.length : void 0) === 0) {
      $(this).autocomplete('close');
    }
  });

  $scope.websiteLinkToggle = function() {
    $scope.websiteField = !$scope.websiteField;
    if ($scope.websiteField) {
      $scope.websiteFieldText = "Remove website";
    } else {
      $("#organization_website").val("");
      $scope.websiteFieldText = "Add website (optional)";
    }
  }

  $scope.validationSectionToggle = function() {
    $scope.validationSection = !$scope.validationSection;
    if ($scope.validationSection) {
      $scope.validationSectionText = "Remove validator";
    } else {
      $("#organization_contacts_attributes_0_name").val("");
      $("#organization_contacts_attributes_0_email").val("");
      $scope.validationSectionText = "Add validator (optional)";
    }
  }

  function initialWebsiteLinkText() {
    var pageType = $(".open-website-form-link").attr("data-page-type")
    if (pageType == "hasSite") {
      $scope.websiteField = true;
      $scope.websiteFieldText = "Remove website";
    } else {
      $scope.websiteField = false;
      $scope.websiteFieldText = "Add website (optional)";
    }
  }

  function initialValidationSectionText() {
    var pageType = $(".organization-validation-form-section").attr("data-page-type")
    if (pageType == "hasContact") {
      $scope.validationSection = true;
      $scope.validationSectionText = "Remove validator";
    } else {
      $scope.validationSection = false;
      $scope.validationSectionText = "Add validator (optional)";
    }
  }
}]);