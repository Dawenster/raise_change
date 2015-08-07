var app = angular.module('raisechange.services');

app.factory("Popover", function() {
  var Popover = {};

  Popover.initialize = function() {
    $(function () {
      $('[data-toggle="popover"]').popover()
    })
  }

  return Popover;
});