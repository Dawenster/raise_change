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
    // Max is defaulted to 10% above what the total quarterly is estimated to be
    $scope.maxDonation = parseInt(Math.round(parseFloat($scope.totalQuarterlyDonation) * 1.1))
    $scope.minimumMaxAmount = Math.ceil($scope.totalQuarterlyDonation)
    if(!$scope.$$phase) {
      $scope.$apply()
    }
  });

  slider.noUiSlider.on('change', function ( values, handle ) {
    if ( values[handle] < 0.25 ) {
      slider.noUiSlider.set(0.25);
    }
  });

  $scope.addHour = function() {
    $scope.maxDonation = parseInt($scope.maxDonation) + 1;
  }

  $scope.subtractHour = function() {
    if (parseInt($scope.maxDonation) > $scope.minimumMaxAmount) {
      $scope.maxDonation = parseInt($scope.maxDonation) - 1;
    }
  }

  $(".custom-hours-input").blur(function() {
    if (parseInt($scope.maxDonation) < $scope.minimumMaxAmount) {
      $scope.maxDonation = $scope.minimumMaxAmount
      if(!$scope.$$phase) {
        $scope.$apply()
      }
    }
  })
}]);