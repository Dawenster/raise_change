var app = angular.module('raisechange');

app.controller('CampaignFormCtrl', ['$scope', function($scope) {
  // initialWebsiteLinkText();
  // initialValidationSectionText();

  // Add class to autocomplete field
  
  $("#campaign_organization_name").addClass("form-control")

  $("#campaign_organization_name").on('autocompleteresponse', function(event, ui) {
    var content;
    if (((content = ui.content) != null ? content[0].id.length : void 0) === 0) {
      $(this).autocomplete('close');
    }
  });

  // $scope.websiteLinkToggle = function() {
  //   $scope.websiteField = !$scope.websiteField;
  //   if ($scope.websiteField) {
  //     $scope.websiteFieldText = "Remove website";
  //   } else {
  //     $("#organization_website").val("");
  //     $scope.websiteFieldText = "Add website (optional)";
  //   }
  // }

  // $scope.validationSectionToggle = function() {
  //   $scope.validationSection = !$scope.validationSection;
  //   if ($scope.validationSection) {
  //     $scope.validationSectionText = "Remove validator";
  //   } else {
  //     $("#organization_contacts_attributes_0_name").val("");
  //     $("#organization_contacts_attributes_0_email").val("");
  //     $scope.validationSectionText = "Add validator (optional)";
  //   }
  // }

  // function initialWebsiteLinkText() {
  //   var pageType = $(".open-website-form-link").attr("data-page-type")
  //   if (pageType == "hasSite") {
  //     $scope.websiteField = true;
  //     $scope.websiteFieldText = "Remove website";
  //   } else {
  //     $scope.websiteField = false;
  //     $scope.websiteFieldText = "Add website (optional)";
  //   }
  // }

  // function initialValidationSectionText() {
  //   var pageType = $(".organization-validation-form-section").attr("data-page-type")
  //   if (pageType == "hasContact") {
  //     $scope.validationSection = true;
  //     $scope.validationSectionText = "Remove validator";
  //   } else {
  //     $scope.validationSection = false;
  //     $scope.validationSectionText = "Add validator (optional)";
  //   }
  // }

  $('body').on('click', '.submit-button', function(e) {
    if (!$(this).is(":disabled")) {
      $(".campaign-form").submit()
    }
    $(this).attr("disabled", "disabled")
  });

  // To so feedback after image file select

  $(".general-form-holder").on('change', '.btn-file :file', function() {
    var input = $(this),
        numFiles = input.get(0).files ? input.get(0).files.length : 1,
        label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
    input.trigger('fileselect', [numFiles, label]);
  });

  $(".general-form-holder").ready( function() {
    $('.btn-file :file').on('fileselect', function(event, numFiles, label) {
      var input = $(this).parents('.input-group').find(':text'),
          log = numFiles > 1 ? numFiles + ' files selected' : label;
      
      if (input.length) {
        input.val(log);
      } else {
        if (log) {
          $(".selected-image-file-name").text(log)
        }
      }
    });
  });
}]);