var app = angular.module('raisechange');

app.controller('DonatedToGridCtrl', ['$scope', function($scope) {
  $scope.deleteDonation = function($event) {
    var firstName = $($event.target).attr("data-user-name")
    swal({
      title: "Are you sure?",
      text: firstName + " will be sad to lose your support!",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, delete it!",
      closeOnConfirm: false
    }, function(){
      var deleteUrl = $($event.target).attr("data-delete-path")
      $.ajax({
        url: deleteUrl,
        method: 'delete'
      }).done(function(data) {
        swal({
          title: "Deleted!",
          text: "You have deleted your support.",
          type: "success",
          showCancelButton: false
        }, function(){
          window.location = data.url
        });
      })
    });
  }
}]);