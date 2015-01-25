var app = angular.module('raisechange');

app.controller('DonationCtrl', ['$scope', function($scope) {
  $("input.stripe-card-number").payment('formatCardNumber')
  $("input.stripe-expiry").payment('formatCardExpiry');
  $("input.stripe-cvc").payment('formatCardCVC');

  $scope.makeDonation = function() {
    var $form = $("#payment-form");

    // Disable the submit button to prevent repeated clicks
    $(".make-donation-button").attr("disabled", "disabled");

    Stripe.card.createToken($form, stripeResponseHandler);

    // Prevent the form from submitting with the default action
    return false;
  }

  function stripeResponseHandler(status, response) {
    var $form = $('#new_donation');

    if (response.error) {
      // Show the errors on the form
      removeStripeErrors()
      $form.find('.payment-errors-' + response.error.param).text(response.error.message + " ");
      $(".make-donation-button").removeAttr("disabled");
    } else {
      // response contains id and card, which contains additional card details
      var token = response.id;
      // Insert the token into the form so it gets submitted to the server
      $form.append($('<input type="hidden" name="stripeToken" />').val(token));
      // and submit
      $form.get(0).submit();
    }
  };

  function removeStripeErrors() {
    var errorFields = $(".stripe-card-error")
    for (var i = 0; i < errorFields.length; i++) {
      $(errorFields[i]).text("")
    };
  }

  $scope.splitDate = function() {
    if ($scope.expiryDate && $scope.expiryDate.length > 6) {
      var expiry = $scope.expiryDate.split("/")
      $scope.month = expiry[0].trim()
      $scope.year = expiry[1].trim()
    }
  }
}]);