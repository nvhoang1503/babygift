class window.Card
  constructor: ->
    @CARD_TYPE_VALIDATORS = [
      { value: CARD_TYPE.am_express.toString(), reg: /^3[47][0-9]{13}$/ },
      { value: CARD_TYPE.discover.toString(), reg: /^6(?:011|5[0-9]{2})[0-9]{12}$/ },
      { value: CARD_TYPE.visa.toString(), reg: /^4[0-9]{12}(?:[0-9]{3})?$/ },
      { value: CARD_TYPE.master.toString(), reg: /^5[1-5][0-9]{14}$/ }
    ]

  validateCard:  =>
    $('#card_number').blur @onCardNumBlur
    $('#card_security').blur @isExistCvv
    $.each ['#date_exp_month', '#date_exp_year'], (idx, val) =>
      $(val).change => @isValidExpirationDate('#date_exp_month', '#date_exp_year')

  onCardNumBlur: =>
    if @isExistCardNum()
      @isCorrectCardNum() if @isExistCardType()

  onCardTypeChange: =>
    if @isExistCardType()
      @isCorrectCardNum() if $('#card_number').val().trim() != ''

  isExistCardNum: ->
    card_num = $('#card_number')
    if card_num.val().trim() == ''
      if card_num.siblings('.error').length==0
        card_num.after("<span class='error blank'>#{message.not_blank}</span>")
      else
        card_num.siblings('.error.blank').text "#{message.not_blank}"
      return false
    else
      card_num.siblings('.error.blank').remove()
      return true

  isExistCvv: ->
    card_num = $('#card_security')
    if card_num.val().trim() == ''
      if card_num.siblings('.error').length==0
        card_num.siblings('a').after("<span class='error blank'>#{message.not_blank}</span>")
      else
        card_num.siblings('.error.blank').text "#{message.not_blank}"
      return false
    else
      card_num.siblings('.error.blank').remove()
      return true

  isExistCardType: ->
    card_type = $('input[type=radio][name=card_type]:checked')
    if card_type.length == 0
      if $('#payment_card').siblings('.error').length==0
        $('#payment_card').after("<span class='error'>#{message.card_missing}</span>")
      else
        $('#payment_card').siblings('.error').text "#{message.card_missing}"
      return false
    else
      $('#payment_card').siblings('.error').remove()
      return true

  isCorrectCardNum: ->
    result = true
    card_type = $('input[type=radio][name=card_type]:checked')
    card_num = $('#card_number')
    for validator in @CARD_TYPE_VALIDATORS
      if validator.value == card_type.val()
        if !validator.reg.test card_num.val().trim()
          if card_num.siblings('.error').length==0
            card_num.after("<span class='error mismatch'>#{message.card_format}</span>")
          else
            card_num.siblings('.error.mismatch').text "#{message.card_format}"
          result = false
        break
    card_num.siblings('.error.mismatch').remove() if result
    return result

  validateCardInfo: =>
    result = @isValidExpirationDate('#date_exp_month', '#date_exp_year')
    result = @isExistCardNum() and result
    result = @isExistCardType() and result
    result = @isCorrectCardNum() and result
    result = @isExistCvv() and result
    return result

  isValidExpirationDate: (mon_elem, year_elem) ->
    month = $(mon_elem).val()
    year = $(year_elem).val()
    exp_date = new Date(year, month, 0, 23, 59, 59)
    current_date = new Date
    result = (exp_date >= current_date)
    helper.showErrorMessage(result, year_elem, message.invalid_expiration)
    return result
