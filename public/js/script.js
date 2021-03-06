$(function(){
  var $window = $(window);
  var $body = $(document.body);

  var navHeight = $('.side-navbar').outerHeight(true) + 10;

  $body.scrollspy({
    target: '.bs-sidebar',
    offset: navHeight
  });

  $window.on('load', function() {
    $body.scrollspy('refresh')
  });

  $('.bs-docs-container [href=#]').click(function(e) {
    e.preventDefault()
  });

  setTimeout(function() {
    var $sideBar = $('.bs-sidebar')

    $sideBar.affix({
      offset: {
        top: function() {
          var offsetTop = $sideBar.offset().top
          var sideBarMargin = parseInt($sideBar.children(0).css('margin-top'), 10)
          var navOuterHeight = $('.bs-docs-nav').height()

          return (this.top = offsetTop - navOuterHeight - sideBarMargin)
        },
        bottom: function() {
          return (this.bottom = $('.bs-footer').outerHeight(true))
        }
      }
    })
  }, 100);

  $('.view-commits').click(function() {
    $(this).parent().children('.modal-commits').modal('toggle');
  });
});

$(document).ready(function() { 
  $(".tablesorter").tablesorter({sortList: [[0,0]]});
}); 