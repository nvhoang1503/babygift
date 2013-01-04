class window.Enrolment
  constructor: ->
    helper.initCvvPopup()
    @card = new Card if window.Card
    @card.validateCard() if @card
    helper.initTermsNConditionsPopup()
    @initDatepicker()
    @autoshowTooltip()
    @updateShipToBilling()
    @genderSelectChecking()
    @planSelectChecking()

    $('#plan-addresses').delegate '#ship_to_billing input', 'click', @copyAddress
    $('#plan-addresses').delegate '#plan_billing_address_attributes_zip, #plan_shipping_address_attributes_zip', 'keypress', helper.validateZip
    $('#plan-addresses').delegate '#plan_billing_address_attributes_phone, #plan_shipping_address_attributes_phone', 'keypress', helper.validatePhone
    $('#frm-payment').submit @onPaymentSubmit
    $('#enroll-steps li').click @onEnrollNavClick
    $('#card_security').keypress helper.validateCvv
    $('.icon-credit-card').click @onCardChange
    $('.icon-gender').click @onGenderChange
    $('.icon-plan').click @onPlanChange
    $('.icon-plan .price').click @onPlanChange

  initDatepicker: ->
    $('#child_birthday').datepicker({
      format: 'mm/dd/yyyy'
      weekStart: 1
      autoclose: true
      todayHighlight: true
      startView: 0
    }).on 'changeDate', ->
      if $('#child_birthday').val().trim() != ''
        $('#child_birthday ~ label.inputHintOverlay').css({display:'none'})
    $('#child-register').inputHintOverlay() if $('#child-register').length > 0

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

  onCardChange: (event) =>
    helper.changeCardOnClick(event.target, @card.onCardTypeChange)

  genderSelectChecking: ->
    $('.btn_child_form').live 'click', ->
      ck = $('input[name="child[gender]"]').is(':checked')
      helper.showErrorMessage(ck,'#gender' , message.selection_missing, 'gender_error')
      if !ck
        $("#child-register").submit()


  planSelectChecking: ->
    $('.btn_plan_form').live 'click', ->
      ck = $('input[name="plan[plan_type]"]').is(':checked')
      helper.showErrorMessage(ck,'.plan-section' , message.selection_missing, 'plan_error')




