$(document).ready(function() {
  $('body').on('click', '.navbar-avatar', function (event, tab) {
    $(".user-account-dropdown").dropdown("toggle")
    return false;
  });

  $("input.stripe-card-number").payment('formatCardNumber')
  $("input.stripe-expiry").payment('formatCardExpiry');
  $("input.stripe-cvc").payment('formatCardCVC');
});