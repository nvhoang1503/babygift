# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class window.Gift
  constructor: ->
    helper.initCvvPopup()
    @card = new Card if window.Card
    @card.validateCard() if @card
    @initFormGiftInfo()
    $('.icon-plan').click @onPlanChange
    $('.icon-plan .price').click @onPlanChange
    $('.icon-credit-card').click @onCardChange
    $('#frm-payment').submit @onPaymentSubmit
    $('#card_security').keypress helper.validateCvv

  onCardChange: (event) =>
    helper.changeCardOnClick(event.target, @card.onCardTypeChange)

  onPlanChange: (event) ->
    helper.changePlanOnClick(event.target)

  onPaymentSubmit: (event) =>
    return helper.checkTermsNConditions(cb_terms, @card.validateCardInfo)

  initFormGiftInfo: ->
    func =-> $('#gift-info').inputHintOverlay() if $('#gift-info').length > 0
    window.setTimeout(func, 200)
