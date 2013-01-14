class window.Register
  constructor: ->
    $('#user_email').keypress helper.validateEmail
    $('#user_mail_register').keypress helper.validateEmail
    $('#email_register_conform').keypress helper.validateEmail
    @checkValidRegisterEmail()
    @checkValidRegisterEmailConform()
    @checkValidLoginEmail()
    @checkRegisterEmail()


  checkValidRegisterEmail: ->
    $('#user_mail_register').blur ->
      email = $('#user_mail_register').val()
      helper.showErrorMessage(helper.isEmail(email),'.register_email_field',message.invalid_email)

  checkValidRegisterEmailConform: ->
    $('#email_register_conform').blur ->
      email = $('#email_register_conform').val()
      helper.showErrorMessage(helper.isEmail(email),'.register_email_conform_field',message.invalid_email)

  checkValidLoginEmail: ->
    $('#user_email').blur ->
      email = $('#user_email').val()
      helper.showErrorMessage(helper.isEmail(email),'.login_email_field',message.invalid_email)

  checkRegisterEmail: ->
    $(".btn_register").live 'click', ->
      email = $('#user_mail_register').val()
      email_cf = $('#email_register_conform').val()
      if helper.isEmail(email) && helper.isEmail(email_cf)
        # if email != email_cf
        helper.showErrorMessage((email == email_cf),'.register_email_field',message.not_match)
        return false
