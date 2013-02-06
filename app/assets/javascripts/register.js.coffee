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
    @checkValidForgotEmail()
    @checkPassComform()


  checkValidRegisterEmail: ->
    $('#user_mail_register').blur ->
      email = $('#user_mail_register').val()
      email_cf = $('#email_register_conform').val()
      if email.length > 0
        # if helper.isEmail(email)
        #   helper.showErrorMessage(true,'.register_email_field',message.invalid_email)
        # else
        #   helper.showErrorMessage(true,'.register_email_conform_field',message.invalid_email)
        #   helper.showErrorMessage(false,'.register_email_field',message.invalid_email)
        if helper.isEmail(email) && email_cf.length > 0
          if !helper.isEmail(email_cf)
            helper.showErrorMessage(false,'.register_email_conform_field',message.invalid_email)
          else if email == email_cf
            helper.showErrorMessage(true,'.register_email_conform_field',message.email_not_match)
          else
            helper.showErrorMessage(true,'#user_email_register',message.email_not_match)
            helper.showErrorMessage(false,'.register_email_conform_field',message.email_not_match)
      else
        helper.showErrorMessage(true,'#user_email_register',message.invalid_email)


  checkValidRegisterEmailConform: ->
    $('#email_register_conform').blur ->
      email = $('#user_mail_register').val()
      email_cf = $('#email_register_conform').val()
      if email_cf.length > 0
        if !helper.isEmail(email_cf)
          helper.showErrorMessage(true,'#user_email_register',message.invalid_email)
          helper.showErrorMessage(false,'.register_email_conform_field',message.invalid_email)
        else if email.length > 0
          if email == email_cf
            helper.showErrorMessage(true,'.register_email_conform_field',message.email_not_match)
          else
            if !helper.isEmail(email)
              helper.showErrorMessage(true,'.register_email_conform_field',message.email_not_match)
              helper.showErrorMessage(false,'#user_email_register',message.invalid_email)
            else
              helper.showErrorMessage(true,'#user_email_register',message.email_not_match)
              helper.showErrorMessage(false,'.register_email_conform_field',message.email_not_match)
      else
        if email.length > 0
          helper.showErrorMessage(true,'#user_email_register',message.not_blank)


  checkValidLoginEmail: ->
    $('#user_email').blur ->
      email = $('#user_email').val()
      $('#exsting_email').remove()

  closeAlertDevise: ->
    $('#user_password').blur ->
      $('#exsting_email').remove()
      vl = $('#user_password').val()
      if vl.length == 0
        helper.showErrorMessage(false,'#user_password',message.not_blank)
      else
        helper.showErrorMessage(true,'#user_password',message.not_blank)


  checkPassComform: ->
    $('#user_passwork_register').blur ->
      pass = $('#user_passwork_register').val()
      pass_cf = $('#user_passwork_confirm_register').val()
      if pass.length >= 6 && pass_cf.length >= 6
        if pass == pass_cf
          helper.showErrorMessage(true,'#user_passwork_confirm_register',message.pass_not_match)
        else
          helper.showErrorMessage(false,'#user_passwork_confirm_register',message.pass_not_match)
      else if pass.length == 0
        helper.showErrorMessage(false,'#user_passwork_register',message.not_blank)
      else if pass.length >= 6 && pass.length <= 20
        helper.showErrorMessage(true,'#user_passwork_register',message.not_blank)

    $('#user_passwork_confirm_register').blur ->
      pass = $('#user_passwork_register').val()
      pass_cf = $('#user_passwork_confirm_register').val()
      if pass_cf.length >= 0
        if pass == pass_cf
          helper.showErrorMessage(true,'#user_passwork_confirm_register',message.pass_not_match)
        else
          helper.showErrorMessage(false,'#user_passwork_confirm_register',message.pass_not_match)



  checkValidForgotEmail: ->
    $('.btn_forgot').live 'click', ->
      email = $('#user_email').val()
      # $('.login_email_field span.error').remove()
      if email.length > 0
        return helper.showErrorMessage(helper.isEmail(email),'#user_email',message.invalid_email)
      else
        return helper.showErrorMessage(helper.isEmail(email),'#user_email',message.not_blank)



  checkRegisterEmail: ->
    $(".btn_register").live 'click', ->
      email = $('#user_mail_register').val()
      email_cf = $('#email_register_conform').val()
      pass = $('#user_passwork_register').val()
      pass_cf = $('#user_passwork_confirm_register').val()
      flag = true
      if email.length > 0
        if helper.isEmail(email) && helper.isEmail(email_cf)
          flag = helper.showErrorMessage((email == email_cf),'#user_email_register',message.not_match)
        else if !helper.isEmail(email)
          # $('.register_email_field span.error').remove()
          flag = helper.showErrorMessage(helper.isEmail(email),'#user_email_register',message.invalid_email)
        else if !helper.isEmail(email_cf)
          flag = helper.showErrorMessage(helper.isEmail(email_cf),'.register_email_conform_field',message.invalid_email)
      else
        helper.showErrorMessage(false,'#user_mail_register',message.not_blank)
        flag = false
      if pass.length == 0
        helper.showErrorMessage(false,'#user_passwork_register',message.not_blank)
        flag = false
      if pass != pass_cf
        helper.showErrorMessage(false,'#user_passwork_confirm_register',message.pass_not_match)
        flag = false
      return flag


  checkLoginEmail: ->
    $(".btn_login").live 'click', ->
      email = $('#user_email').val()
      pass = $('#user_password').val()
      flag = true
      $('#exsting_email').remove()
      if email.length > 0
        flag =  helper.showErrorMessage(helper.isEmail(email),'#user_email',message.invalid_email)
      else
        flag =  helper.showErrorMessage(false,'#user_email',message.not_blank)
      if pass.length == 0
        flag =  helper.showErrorMessage(false,'#user_password',message.not_blank)
      return flag







