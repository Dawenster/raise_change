var app = angular.module('raisechange');

app.controller('CharityAdminCtrl', ['$scope', function($scope) {
  $scope.verifyEntry = function($event) {
    var url = $($event.target).attr("data-url")
    $.ajax({
      url: url,
      method: "post"
    })
    $($event.target).parents("td").html("Verified")
  }
}]);