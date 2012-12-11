class window.Card
  constructor: ->
    @CARD_TYPE_VALIDATORS = [
      { value: CARD_TYPE.am_express.toString(), reg: /^3[47][0-9]{13}$/ },
      { value: CARD_TYPE.discover.toString(), reg: /^6(?:011|5[0-9]{2})[0-9]{12}$/ },
      { value: CARD_TYPE.visa.toString(), reg: /^4[0-9]{12}(?:[0-9]{3})?$/ },
      { value: CARD_TYPE.master.toString(), reg: /^5[1-5][0-9]{14}$/ }
    ]

  validateCard:  ->
    $('#card_number').blur @validateCardInfo
    $('input[type=radio][name=card_type]').change @validateCardInfo

  validateCardInfo: =>
    result = true
    card_type = $('input[type=radio][name=card_type]:checked')
    card_num = $('#card_number')
    if card_num.val().trim() == ''
      if card_num.siblings('.error').length==0
        card_num.after("<span class='error'>can't be blank</span>")
      else
        card_num.siblings('.error').text "can't be blank"
      result = false

    if result and card_type.length == 0
      if $('#payment_card').siblings('.error').length==0
        $('#payment_card').after("<span class='error'>choose a card</span>")
      else
        $('#payment_card').siblings('.error').text 'choose a card'
      result = false

    if result
      for validator in @CARD_TYPE_VALIDATORS
        if validator.value == card_type.val()
          if !validator.reg.test card_num.val().trim()
            if card_num.siblings('.error').length==0
              card_num.after("<span class='error'>does not match the card type </span>")
            else
              card_num.siblings('.error').text 'does not match the card type'
            result = false
            break
    return result
