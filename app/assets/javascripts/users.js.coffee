class window.User
  constructor: ->
    $('#user_mail').keypress helper.validateEmail
    @checkValidCurPass()
    @checkValidNewPass()
    @checkValidCfNewPass()
    @checkValidAccountEmail()
    @checkValidChangePass()
    helper.initDatepicker('#plan_baby_attributes_birthday')
    @reloadPlan()

  checkValidCurPass: ->
    $('#user_current_password').blur ->
      cur_pass = $("#user_current_password").val()
      if cur_pass.length <= 0
        helper.showErrorMessage(false,'#user_current_password',message.not_blank)
      else
        if cur_pass.length < 6 or  cur_pass.length > 20
          if cur_pass.length < 6
            helper.showErrorMessage(false,'#user_current_password',message.pass_format_6)
          else
            helper.showErrorMessage(false,'#user_current_password',message.pass_format_20)
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

  checkValidChangePass: ->
    $('.btn_change_password').live 'click', ->
      cur_pass = $("#user_current_password").val()
      new_pass = $("#new_password").val()
      cf_new_pass = $("#cf_new_password").val()
      flag = true
      if cur_pass.length <= 0
        helper.showErrorMessage(false,'#user_current_password',message.not_blank)
        flag = false
      if new_pass.length <= 0
        helper.showErrorMessage(false,'#new_password',message.not_blank)
        flag = false
      if cf_new_pass.length <= 0 or new_pass != cf_new_pass
        flag = false
      return flag

  reloadPlan: ->
    $("#child_id").change ->
      baby_id = $("#child_id").val()
      $.ajax
        type: "GET"
        url: "/users/reload_plan"
        data: {baby_id: baby_id}
        dataType: 'json'
        success: (response)->
          if response.success
            data = response.data
            $('#plan_baby_attributes_first_name').val(data.first_name)
            $('#plan_baby_attributes_last_name').val(data.last_name)
            $('#plan_baby_attributes_birthday').val(data.birthday)
            $('#plan_baby_attributes_gender').val(data.gender)
            $('#plan-info').text(data.plan)
          else
            alert(response.msg)
        error: (response)->
          alert(message.server_error)





