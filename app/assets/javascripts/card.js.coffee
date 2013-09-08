class window.Card
  constructor: ->
    @CARD_TYPE_VALIDATORS = [
      { value: CARD_TYPE.am_express.toString(), reg: /^3[47][0-9]{13}$/, class: 'am-express' },
      { value: CARD_TYPE.discover.toString(), reg: /^6(?:(011|5[0-9]{2}))[0-9]{12}$/, class: 'discover' },
      { value: CARD_TYPE.visa.toString(), reg: /^4[0-9]{12}(?:[0-9]{3})?$/, class: 'visa' },
      { value: CARD_TYPE.master.toString(), reg: /^5[1-5][0-9]{14}$/, class: 'master' }
    ]

  validateCard:  =>
    @autoSelectCardType() if $('#card_number').val().replace(/\s/g,'')!=''
    $('#card_number').blur @autoSelectCardType
    $('#card_security').blur @isExistCvv
    $.each ['#date_exp_month', '#date_exp_year'], (idx, val) =>
      $(val).change => @isValidExpirationDate('#date_exp_month', '#date_exp_year')

  autoSelectCardType: =>
    if @isExistCardNum()
      @validateCardNum true
    else
      $('input[type=radio][name=card_type]').prop('checked', false)
      $('.icon-credit-card').removeClass('selected')

  changeCardOnClick: (target) ->
    target = $(target)
    $('.icon-credit-card').not(target).removeClass('selected')
    target.addClass('selected')
    rad = target.closest('span').find('input:radio')
    rad.prop('checked', true)
    $('input:radio').not(rad).prop('checked', false)

  validateCardNum: (card_checking=false) =>
    result = false
    card_num = $('#card_number')

    for validator in @CARD_TYPE_VALIDATORS
      if validator.reg.test card_num.val().replace(/\s/g,'')
        result = true
        break
    helper.showErrorMessage(result, '#card_number', message.card_format, 'mismatch')
    if result
      @changeCardOnClick(".icon-credit-card.#{validator.class}") if card_checking
      card_num.siblings('.error.mismatch').remove()
    else
      $('input[type=radio][name=card_type]').prop('checked', false)
      $('.icon-credit-card').removeClass('selected')

    return result

  isExistCardNum: ->
    card_num = $('#card_number')
    if card_num.val().replace(/\s/g,'') == ''
      if card_num.siblings('.error').length==0
        card_num.after("<span class='error blank'>#{message.not_blank}</span>")
      else
        card_num.siblings('.error').text "#{message.not_blank}"
      return false
    else
      card_num.siblings('.error.blank').remove()
      return true

  isExistCvv: ->
    card_num = $('#card_security')
    if card_num.val().replace(/\s/g,'') == ''
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


  validateCardInfo: =>
    return true
    # result = @isValidExpirationDate('#date_exp_month', '#date_exp_year')
    # result = @isExistCardNum() and result
    # result = (@validateCardNum() and result) if result
    # result = @isExistCvv() and result
    # return result

  isValidExpirationDate: (mon_elem, year_elem) ->
    month = $(mon_elem).val()
    year = $(year_elem).val()
    exp_date = new Date(year, month, 0, 23, 59, 59)
    current_date = new Date
    result = (exp_date >= current_date)
    helper.showErrorMessage(result, year_elem, message.invalid_expiration)
    return result

  validateCardNumWithType: =>
    if @isExistCardNum()
      @isCorrectCardNumWithType() if @isExistCardType()

  validateSelectedCardType: =>
    if @isExistCardType()
      @isCorrectCardNumWithType() if $('#card_number').val().replace(/\s/g,'') != ''

  isCorrectCardNumWithType: ->
    result = true
    card_type = $('input[type=radio][name=card_type]:checked')
    card_num = $('#card_number')
    for validator in @CARD_TYPE_VALIDATORS
      if validator.value == card_type.val()
        if !validator.reg.test card_num.val().replace(/\s/g,'')
          if card_num.siblings('.error').length==0
            card_num.after("<span class='error mismatch'>#{message.card_format}</span>")
          else
            card_num.siblings('.error.mismatch').text "#{message.card_format}"
          result = false
        break
    card_num.siblings('.error.mismatch').remove() if result
    return result
