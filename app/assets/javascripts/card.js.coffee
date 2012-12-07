class window.Card
  constructor: ->
    @CARD_TYPE_VALIDATORS = [
      { value: CARD_TYPE.am_express.toString(), reg: /^3[47][0-9]{13}$/ },
      { value: CARD_TYPE.discover.toString(), reg: /^6(?:011|5[0-9]{2})[0-9]{12}$/ },
      { value: CARD_TYPE.visa.toString(), reg: /^4[0-9]{12}(?:[0-9]{3})?$/ },
      { value: CARD_TYPE.master.toString(), reg: /^5[1-5][0-9]{14}$/ }
    ]

  validateCard:  ->
    $('#card_number').change @onCardNumberChange
    $('input[type=radio][name=card_type]').change @onCardTypeChange

  onCardNumberChange: (event) =>
    card_num = event.target.value
    card_type = $('input[type=radio][name=card_type]:checked')
    if card_num.trim().length > 0 and card_type.length == 0
      alert('Select your card type above!')
    else if card_num.trim().length > 0 and card_type.length > 0
      for validator in @CARD_TYPE_VALIDATORS
        if validator.value == card_type.val()
          if !validator.reg.test card_num
            alert('Your card number does not match this type of card!')
          break

  onCardTypeChange: (event) =>
    card_type = event.target.value
    card_num = $('#card_number').val()
    if card_num.trim().length > 0
      for validator in @CARD_TYPE_VALIDATORS
        if validator.value == card_type
          if !validator.reg.test(card_num)
            alert('Your card number does not match this type of card!')
          break
