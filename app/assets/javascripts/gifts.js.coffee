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
    @checkConfirmEmail()

  onCardChange: (event) =>
    helper.changeCardOnClick(event.target, @card.onCardTypeChange)

  onPlanChange: (event) ->
    helper.changePlanOnClick(event.target)

  onPaymentSubmit: (event) =>
    return helper.checkTermsNConditions(cb_terms, @card.validateCardInfo)

  initFormGiftInfo: ->
    func =-> $('#gift-info').inputHintOverlay() if $('#gift-info').length > 0
    window.setTimeout(func, 200)

  checkConfirmEmail: ->
    $('#gift-info').submit =>
      flag1 = @validation_email('#gift_recipient_email' , '#gift_recipient_email_confirm')
      flag2 = @validation_email('#gift_sender_email' , '#gift_sender_email_confirm')
      flag = flag1 && flag2
      return flag

    $("#gift_recipient_email_confirm").live 'blur', =>
      @validation_email('#gift_recipient_email' , '#gift_recipient_email_confirm')

    $("#gift_sender_email_confirm").live 'blur', =>
      @validation_email('#gift_sender_email' , '#gift_sender_email_confirm')

  validation_email: (elem1, elem2) ->
    val1 = $(elem1).val().trim()
    val2 = $(elem2).val().trim()
    s = "<span class='error'>#{message.not_match}</span>"
    if val1 != val2
      if $(elem2).siblings('.error').length == 0
        $(elem2).after(s)
      else
        $(elem2).siblings('.error').text("#{message.not_match}")
      return false
    return true



