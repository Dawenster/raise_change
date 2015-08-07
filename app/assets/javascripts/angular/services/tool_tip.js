var app = angular.module('raisechange.services');

app.factory("ToolTip", function() {
  var ToolTip = {};

  ToolTip.initialize = function() {
    $(function () {
      $('[data-toggle="tooltip"]').tooltip()
    })
  }

  return ToolTip;
});