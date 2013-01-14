class window.Register
  constructor: ->
    $('#user_email').keypress helper.validateEmail
    $('#user_mail_register').keypress helper.validateEmail
    $('#email_register_conform').keypress helper.validateEmail
    @checkValidRegisterEmail()
    @checkValidRegisterEmailConform()
    @checkValidLoginEmail()
    @checkRegisterEmail()
    @checkLoginEmail()
    @closeAlertDevise()


  checkValidRegisterEmail: ->
    $('#user_mail_register').blur ->
      email = $('#user_mail_register').val()
      if email.length > 0
        helper.showErrorMessage(helper.isEmail(email),'.register_email_field',message.invalid_email)
      else
        helper.showErrorMessage(true,'.register_email_field',message.invalid_email)


  checkValidRegisterEmailConform: ->
    $('#email_register_conform').blur ->
      email = $('#user_mail_register').val()
      email_cf = $('#email_register_conform').val()
      if email_cf.length > 0
        helper.showErrorMessage(helper.isEmail(email_cf),'.register_email_conform_field',message.invalid_email)
        if email == email_cf
          helper.showErrorMessage(true,'.register_email_conform_field',message.email_not_match)
        else
          helper.showErrorMessage(false,'.register_email_conform_field',message.email_not_match)
      else
        helper.showErrorMessage(false,'.register_email_conform_field',message.not_blank)


  checkValidLoginEmail: ->
    $('#user_email').blur ->
      email = $('#user_email').val()
      $('#exsting_email').remove()
      if email.length > 0
        helper.showErrorMessage(helper.isEmail(email),'.login_email_field',message.invalid_email)

  closeAlertDevise: ->
    $('#user_password').blur ->
      $('#exsting_email').remove()

  checkRegisterEmail: ->
    $(".btn_register").live 'click', ->
      email = $('#user_mail_register').val()
      email_cf = $('#email_register_conform').val()
      if email.length > 0
        if helper.isEmail(email) && helper.isEmail(email_cf)
          helper.showErrorMessage((email == email_cf),'.register_email_field',message.not_match)
        else if !helper.isEmail(email)
          $('.register_email_field span.error').remove()
          return helper.showErrorMessage(helper.isEmail(email),'.register_email_field',message.invalid_email)
        else if !helper.isEmail(email_cf)
          return helper.showErrorMessage(helper.isEmail(email_cf),'.register_email_conform_field',message.invalid_email)


  checkLoginEmail: ->
    $(".btn_login").live 'click', ->
      email = $('#user_email').val()
      pass = $('#user_password').val()
      flag = true
      if email.length > 0
        flag =  helper.showErrorMessage(helper.isEmail(email),'.login_email_field',message.invalid_email)
      return flag







