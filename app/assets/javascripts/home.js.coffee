# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#slides").slides
    preload: true
    preloadImage: '/assets/common/loading.gif'
    hoverPause: true
    pause: 1000
    play: 5000
    animationStart: ->
      $('.caption').animate({ bottom: -73}, 100)
    animationComplete: ->
      $('.caption').animate({ bottom: 0}, 200)

  $('#kits-slides').slides
    crossfade: false
    preload: true
    preloadImage: '/assets/common/loading.gif'
    hoverPause: true
    pause: 1000
    play: 5000
    generatePagination: false
    generateNextPrev: false
