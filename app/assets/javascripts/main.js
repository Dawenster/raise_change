$(document).ready(function() {
  $('body').on('click', '.navbar-avatar', function (event, tab) {
    $(".user-account-dropdown").dropdown("toggle")
    return false;
  });
});