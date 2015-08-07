var app = angular.module('raisechange');

app.controller('CharityAdminCtrl', ['$scope', function($scope) {
  $scope.verifyEntry = function($event) {
    var url = $($event.target).attr("data-url")
    $.ajax({
      url: url,
      method: "post"
    })
    var parentHolder = $($event.target).parents(".charity-admin-org-holder")
    $($event.target).parents("td").html("Verified")
    checkRemoveVerifyAllButton(parentHolder)
  }

  $scope.verifyAll = function($event) {
    var url = $($event.target).attr("data-url")
    $.ajax({
      url: url,
      method: "post"
    })
    var parentHolder = $($event.target).parents(".charity-admin-org-holder")
    parentHolder.find(".verified-cell").html("Verified")
    checkRemoveVerifyAllButton(parentHolder)
  }

  function checkRemoveVerifyAllButton(parentHolder) {
    var verifyButtons = parentHolder.find(".verify-button")
    if (verifyButtons.length == 0) {
      parentHolder.find(".verify-all-button").hide()
    }
  }
}]);