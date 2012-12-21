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
    @checkSelectPlan()
    @checkBillingValid()

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
      flag1 = @validateConfirmEmail('#gift_recipient_email' , '#gift_recipient_email_confirm')
      flag2 = @validateConfirmEmail('#gift_sender_email' , '#gift_sender_email_confirm')
      flag = flag1 && flag2
      return flag

    $("#gift_recipient_email").live 'blur', =>
      if $('#gift_recipient_email_confirm').val().length > 0
        @validateConfirmEmail('#gift_recipient_email' , '#gift_recipient_email_confirm')

    $("#gift_recipient_email_confirm").live 'blur', =>
      @validateConfirmEmail('#gift_recipient_email' , '#gift_recipient_email_confirm')

    $("#gift_sender_email").live 'blur', =>
      if $('#gift_sender_email_confirm').val().length > 0
        @validateConfirmEmail('#gift_sender_email' , '#gift_sender_email_confirm')
    $("#gift_sender_email_confirm").live 'blur', =>
      @validateConfirmEmail('#gift_sender_email' , '#gift_sender_email_confirm')

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
    else
      $(elem2).siblings('.error').remove()
      return true

  validateConfirmEmail: (elem1, elem2) =>
    result = true
    target = $(elem2)
    if isEmail($(target).val().trim())
      result = @validation_email(elem1 , elem2)
    else if target.siblings('.error').length == 0
      s = "<span class='error'>#{message.invalid_email}</span>"
      target.after(s)
      result = false
    else
      target.siblings('.error').text("#{message.invalid_email}")
      result = false
    return result

  checkSelectPlan: ->
    $('#gift-plan').live 'submit',  ->
      if $('input:radio:checked').length == 0
        helper.showFlashMessage(message.plan_missing)
        return false

  checkBillingValid: ->
    $('#gift_billing_address_attributes_zip').keypress helper.validateZip
    $('#gift_billing_address_attributes_phone').keypress helper.validatePhone
    $('#gift_billing_address_attributes_phone').live 'blur', ->
      phone_num = $(@).val().replace(/\s/g, '')

      if phone_num.length != 0
        reg = /^\d{5,15}$/
        if phone_num.indexOf('--') >= 0
          helper.showErrorMessage(false, @, message.phone_format)
        else if phone_num.indexOf('-') >= 0
          phone_num = phone_num.replace(/-/g, '')
          helper.showErrorMessage(reg.test(phone_num), @, message.phone_format)
        else
          helper.showErrorMessage(reg.test(phone_num), @, message.phone_invalid)
      else if $(@).siblings('.error').length > 0
          $(@).siblings('.error').remove()
