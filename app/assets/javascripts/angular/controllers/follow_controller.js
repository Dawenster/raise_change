var app = angular.module('raisechange');

app.controller('FollowCtrl', ['$scope', function($scope) {
  initialFollowStatus()
  $scope.hovering = false

  // Initialize tooltip feature
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })

  function initialFollowStatus() {
    var status = $(".follow-section-holder").attr("data-following") == "true"
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