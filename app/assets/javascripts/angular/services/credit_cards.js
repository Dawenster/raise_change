var app = angular.module('raisechange.services', []);

app.factory("CreditCards", function() {
  var CreditCards = {};

  CreditCards.makeDonation = function() {
    if (hasCard() == "true") {
      var $form = getCorrectForm()
      $form.get(0).submit();
    } else {
      var $form = $(".payment-form");

      // Disable the submit button to prevent repeated clicks
      $(".make-donation-button").attr("disabled", "disabled");

      Stripe.card.createToken($form, stripeResponseHandler);

      // Prevent the form from submitting with the default action
      return false;
    }
  }

  CreditCards.splitDate = function(expiryDate) {
    if (expiryDate && expiryDate.length > 6) {
      var expiry = expiryDate.split("/")
      return {
        month: expiry[0].trim(),
        year: expiry[1].trim()
      }
    }
  }

  function stripeResponseHandler(status, response) {
    var $form = getCorrectForm();

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

  function getCorrectForm() {
    if ($('#new_donation').length > 0) {
      return $('#new_donation')
    } else if ($('#payment-form').length > 0) {
      return $('#payment-form')
    }
  }

  function hasCard() {
    return getCorrectForm().find(".has-card-details").attr("data-has-card")
  }

  function removeStripeErrors() {
    var errorFields = $(".stripe-card-error")
    for (var i = 0; i < errorFields.length; i++) {
      $(errorFields[i]).text("")
    };
  }

  return CreditCards;
});