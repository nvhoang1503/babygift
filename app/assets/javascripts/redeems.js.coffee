class window.Redeem
  constructor: ->
    helper.initTermsNConditionsPopup()
    @checkBillingValid()
    @reloadChild()
    @onPaymentSubmit()

  onPaymentSubmit: ->
    $('#frm-payment').submit ->
      return helper.checkTermsNConditions('#cb_terms')

  checkBillingValid: ->
    $('#redeem_shipping_address_attributes_zip').keypress helper.validateZip
    $('#redeem_shipping_address_attributes_phone').keypress helper.validatePhone
    $('#redeem_shipping_address_attributes_phone').live 'blur', ->
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

  reloadChild: ->
    $("#child_id").change ->
      baby_id = $("#child_id").val()
      $.ajax
        type: "GET"
        url: "/redeems/reload_child"
        data: {baby_id: baby_id}
        dataType: 'json'
        success: (response)->
          if response.success
            data = response.data
            $('#child_first_name').val(data.first_name)
            $('#child_last_name').val(data.last_name)
            $('#child_birthday').val(data.birthday)
            $('#child_gender').val(data.gender)
          else
            alert(response.msg)
        error: (response)->
          alert(message.server_error)


