class window.Enrolment
  constructor: ->
    helper.initCvvPopup()
    @card = new Card if window.Card
    @card.validateCard() if @card
    @autoshowTooltip()
    @updateShipToBilling()
    @genderSelectChecking()
    @planSelectChecking()
    helper.initDatepicker('#child_birthday')
    @checkBirthdayValid()
    $('#child-register').inputHintOverlay() if $('#child-register').length > 0

    $('#plan-addresses').delegate '#ship_to_billing input', 'click', @copyAddress
    $('#plan-addresses').delegate '#plan_billing_address_attributes_zip, #plan_shipping_address_attributes_zip', 'keypress', helper.validateZip
    $('#plan-addresses').delegate '#plan_billing_address_attributes_phone, #plan_shipping_address_attributes_phone', 'keypress', helper.validatePhone
    $('#frm-payment').submit @onPaymentSubmit
    $('#enroll-steps li').click @onEnrollNavClick
    $('#card_security').keypress helper.validateCvv
    $('.icon-credit-card').click -> return false
    $('.icon-gender').click @onGenderChange
    $('.icon-plan').click @onPlanChange
    $('.icon-plan .price').click @onPlanChange

  autoshowTooltip: ->
    $('.icon-question').not('#cvv-popup').tooltip
      placement: 'right'

  updateShipToBilling: ->
    field_events = {
      'first_name':'keypress',
      'last_name':'keypress',
      'address_1':'keypress',
      'address_2':'keypress',
      'city':'keypress',
      'zip':'keypress',
      'phone':'keypress',
      'state':'change'
    }
    $.each field_events, (key, val) ->
      $('#plan-addresses').delegate "#plan_shipping_address_attributes_#{key}, #plan_billing_address_attributes_#{key}", "#{val}", ->
        if $("#plan_billing_address_attributes_#{key}").val() != $("plan_shipping_address_attributes_#{key}").val()
          $('#ship_to_billing input').prop 'checked', false
          return

  copyAddress: (event) ->
    target = $(event.target)
    if target.is(':checked')
      attrs = ['first_name', 'last_name', 'address_1', 'address_2', 'city', 'state', 'zip', 'phone']
      $.each attrs, (idx, val) ->
        $("#plan_billing_address_attributes_#{val}").val $("#plan_shipping_address_attributes_#{val}").val()
      $('#plan-addresses').resetClientSideValidations()

  onPaymentSubmit: (event) =>
    return helper.checkTermsNConditions('#cb_terms', @card.validateCardInfo)

  onEnrollNavClick: (event) ->
    window.location = $(event.target).find('a').prop('href')

  onGenderChange: (event) ->
    target = $(event.target)
    $('.icon-gender').not(target).removeClass('selected')
    target.addClass('selected')
    rad = target.closest('span').find('input:radio')
    rad.prop('checked', true)
    $('input:radio').not(rad).prop('checked', false)

  onPlanChange: (event) ->
    helper.changePlanOnClick(event.target)

  genderSelectChecking: ->
    $('.btn_child_form').live 'click', ->
      ck = $('input[name="child[gender]"]').is(':checked')
      helper.showErrorMessage(ck,'#gender' , message.selection_missing, 'gender_error')
      if ( $.browser.webkit && $("#child_birthday").val() != "")
        $('#child_birthday').siblings('.error').remove()
        $('#child_birthday').removeAttr("data-validate")
      if $("#child_birthday").val() != ""
        birthday = $("#child_birthday").val()
        birth_data= Date.parse(birthday)
        if birth_data > 0
          helper.showErrorMessage(true,'#child_birthday',message.date_wrong_format)
        else
          helper.showErrorMessage(false,'#child_birthday',message.date_wrong_format)
          return false
      if !ck
        $("#child-register").submit()

  checkBirthdayValid: ->
    $("#child_birthday").live 'blur', ->
      if $("#child_birthday").val() != ""
        birthday = $("#child_birthday").val()
        birth_data= Date.parse(birthday)
        if birth_data > 0
          helper.showErrorMessage(true,'#child_birthday',message.date_wrong_format)
        else
          helper.showErrorMessage(false,'#child_birthday',message.date_wrong_format)

  planSelectChecking: ->
    $('.btn_plan_form').live 'click', ->
      ck = $('input[name="plan[plan_type]"]').is(':checked')
      helper.showErrorMessage(ck,'.plan-section' , message.selection_missing, 'plan_error')




