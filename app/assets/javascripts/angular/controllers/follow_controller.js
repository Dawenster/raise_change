var app = angular.module('raisechange');

app.controller('FollowCtrl', ['$scope', '$element', function($scope, $element) {
  initialFollowStatus($element)
  $scope.hovering = false

  // Initialize tooltip feature
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })

  function initialFollowStatus($element) {
    var status = $($element).attr("data-following") == "true"
    if (status) {
      $scope.following = true
    } else {
      $scope.following = false
    }
  }

  $scope.follow = function() {
    $scope.following = true
    var url = $(event.target).attr("data-follow-url")
    $.ajax({
      url: url,
      method: "post"
    })
    .done(function(data) {
    })
  }

  $scope.unfollow = function() {
    $scope.following = false
    var url = $(event.target).attr("data-unfollow-url")
    $.ajax({
      url: url,
      method: "delete"
    })
    .done(function(data) {
    })
  }
}]);