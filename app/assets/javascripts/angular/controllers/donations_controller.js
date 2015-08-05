var app = angular.module('raisechange');

app.controller('DonationCtrl', ['$scope', "CreditCards", function($scope, CreditCards) {
  $scope.makeDonation = CreditCards.makeDonation
  $scope.quarterlyHours = $(".donations-controller").attr("data-campaign-estimated-quarterly-hours")

  $scope.splitDate = function() {
    var dates = CreditCards.splitDate($scope.expiryDate)
    if (dates) {
      $scope.month = dates.month
      $scope.year = dates.year
    }
  }

  var slider = document.getElementById("amount-slider")

  noUiSlider.create(slider, {
    start: [ 1 ],
    connect: "lower",
    range: {
      'min': [ 0 ],
      'max': [ 5 ]
    }
  });

  slider.noUiSlider.on('update', function( values, handle ) {
    var amount = (Math.round(values[handle] * 4) / 4).toFixed(2)
    $scope.donationAmount = amount
    $scope.totalQuarterlyDonation = (amount * $scope.quarterlyHours).toFixed(2)
    if(!$scope.$$phase) {
      $scope.$apply()
    }
  });

  slider.noUiSlider.on('change', function ( values, handle ) {
    if ( values[handle] < 0.25 ) {
      slider.noUiSlider.set(0.25);
    }
  });
}]);