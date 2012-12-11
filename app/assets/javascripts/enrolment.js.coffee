class window.Enrolment
  constructor: ->
    @card = new Card
    @card.validateCard()
    @initCvvPopup()
    @initDatepicker()
    @autoshowTooltip()
    @updateShipToBilling()
    $('#plan-addresses').delegate '#ship_to_billing input', 'click', @copyAddress
    $('#plan-addresses').delegate '#plan_billing_address_attributes_zip, #plan_shipping_address_attributes_zip', 'keypress', helper.validateZip
    $('#plan-addresses').delegate '#plan_billing_address_attributes_phone, #plan_shipping_address_attributes_phone', 'keypress', helper.validatePhone
    $('#child_birthday').keypress -> return false
    $('#frm-payment').submit @onPaymentSubmit
    $('#enroll-steps li').click @onEnrollNavClick

  initCvvPopup: ->
    img = '<img src="/assets/common/cvv.png" alt="Cvv">'
    $('#cvv-popup').popover
      title: null
      html: 'true'
      content: img
      trigger: 'hover'

  initDatepicker: ->
    $('#child_birthday').datepicker({
      format: 'mm/dd/yyyy'
      weekStart: 1
      autoclose: true
      todayHighlight: true
      startView: 2
    }).on 'changeDate', ->
      if $('#child_birthday').val().trim() != ''
        $('#child_birthday ~ label.inputHintOverlay').css({display:'none'})
    $('#child-register').inputHintOverlay()

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

  onPaymentSubmit: (event) =>
    return @card.validateCardInfo()

  onEnrollNavClick: (event) ->
    window.location = $(event.target).find('a').prop('href')
