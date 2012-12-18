# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class window.Gift
  constructor: ->
    @initFormGiftInfo()
    $('.icon-plan').click @onPlanChange
    $('.icon-plan .price').click @onPlanChange

  onPlanChange: (event) ->
    helper.changePlanOnClick(event.target)

  initFormGiftInfo: ->
    $('#gift-info').inputHintOverlay() if $('#gift-info').length > 0
