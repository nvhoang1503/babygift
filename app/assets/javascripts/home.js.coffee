# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#slides").slides
    preload: true,
    preloadImage: '/assets/common/loading.gif'
    hoverPause: true
    pause: 1000
    play: 3000
    animationStart: ->
      $('.caption').animate({ bottom: -300}, 100)
    animationComplete: ->
      $('.caption').animate({ bottom: -257}, 200)
