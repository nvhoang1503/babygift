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
    $('#btn-cancel').click @cancelPlan

  cancelPlan: ->
    if $("#cancelable").val() != "false"
      plan_id = $(@).attr('data-plan')
      $.ajax
        type: "POST"
        url: "/users/cancel_plan"
        data: {plan_id: plan_id, authenticity_token: auth_token}
        dataType: 'json'
        success: (response)->
          if response.msg
            helper.showFlashMessage(response.msg)
          else
            window.location.href = '/users/child_n_plan'
          $('#btn-cancel').removeClass("mybtn btn-green")
          $('#btn-cancel').addClass("disabled-mybtn btn-gray")
          $("#cancelable").val("false")
        error: (response)->
          alert(message.server_error)

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
      baby = $('#child_id').find('option:selected')
      $.ajax
        type: "GET"
        url: "/users/reload_plan"
        data: {
          plan_id: baby.attr('data-plan-id'),
          enroll: baby.attr('data-enroll'),
          redeem: baby.attr('data-redeem')
        }
        dataType: 'json'
        success: (response)->
          if response.success
            data = response.data
            $('#baby_first_name').val(data.first_name)
            $('#baby_last_name').val(data.last_name)
            $('#baby_birthday').val(data.birthday)
            $('#baby_gender').val(data.gender)
            $('#plan-info').text(data.plan)
            $('#plan_id').val(data.plan_id)
            $('#enroll').val(data.is_enroll_plan)
            $('#redeem').val(data.is_redeem_plan)
            $('#cancelable').val(data.cancelable)
            if data.cancelable
              $('#btn-cancel').removeClass("disabled-mybtn btn-gray").addClass("mybtn btn-green")
            else
              $('#btn-cancel').removeClass("mybtn btn-green").addClass("disabled-mybtn btn-gray")
          else
            alert(response.msg)
        error: (response)->
          alert(message.server_error)
