class window.User
  constructor: ->
    $('#user_mail').keypress helper.validateEmail
    @checkValidCurPass()
    @checkValidNewPass()
    @checkValidCfNewPass()
    @checkValidAccountEmail()

  checkValidCurPass: ->
    $('#user_current_password').blur ->
      cur_pass = $("#user_current_password").val()
      if cur_pass.length <= 0
        helper.showErrorMessage(false,'#user_current_password',message.not_blank)
      else
        if cur_pass.length < 6 or  cur_pass.length > 20
          helper.showErrorMessage(false,'#user_current_password',message.pass_format)
        else
          helper.showErrorMessage(true,'#user_current_password',message.not_blank)


  checkValidNewPass: ->
    $('#new_password').blur ->
      new_pass = $("#new_password").val()
      cf_new_pass = $("#cf_new_password").val()
      if new_pass.length <= 0
        helper.showErrorMessage(false,'#new_password',message.not_blank)
      else
        if new_pass.length >= 6 &&  new_pass.length <= 20
          if cf_new_pass.length > 0
            if  new_pass != cf_new_pass
              helper.showErrorMessage(false,'#cf_new_password',message.pass_not_match)
            else
              helper.showErrorMessage(true,'#cf_new_password',message.pass_not_match)


  checkValidCfNewPass: ->
    $('#cf_new_password').blur ->
      new_pass = $("#new_password").val()
      cf_new_pass = $("#cf_new_password").val()
      if new_pass.length >= 6 &&  new_pass.length <= 20
        if new_pass == cf_new_pass
          helper.showErrorMessage(true,'#cf_new_password',message.pass_not_match)
        else
          helper.showErrorMessage(false,'#cf_new_password',message.pass_not_match)


  checkValidAccountEmail: ->
    $('#user_mail').blur ->
      email = $('#user_mail').val()
      if email.length > 0
        helper.showErrorMessage(helper.isEmail(email),'.email_field',message.invalid_email)

