var app = angular.module('raisechange');

app.controller('AfterCreationModalCtrl', ['$scope', function($scope) {
  var copyTextareaBtn = document.querySelector('.js-textareacopybtn');

  copyTextareaBtn.addEventListener('click', function(event) {
    var copyTextarea = document.querySelector('.js-copytextarea');
    copyTextarea.select();

    try {
      var successful = document.execCommand('copy');
      var msg = successful ? 'successful' : 'unsuccessful';
      console.log('Copying text command was ' + msg);
      $(".copied-text").show().delay(500).fadeOut();
    } catch (err) {
      console.log('Oops, unable to copy');
    }
  });
}]);