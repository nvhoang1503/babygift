# jQuery.validator.addMethod("not_blank", (value, element) ->
#   arr = value.trim().split(",")
#   valid = false
#   return false if arr.length > 1
#		valid = true
#   return this.optional(element) || valid
# , "Please fill out this field=====");


window.isEmail = (email) ->
  pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i)
  pattern.test email

$(".btn_register").live 'click', ->
  email = $("#user_mail_register").val()
  email_conform = $("#email_register_conform").val()
  user_password = $("#user_passwork_register").val()
  user_password_confirmation = $("#user_passwork_confirm_register").val()
  rs = true
  if isEmail(email)
    $("#email_error").removeClass 'error'
    $("#email_error").addClass 'hidden'
  else
    $("#email_error").addClass 'error'
    $("#email_error").removeClass 'hidden'
    if email.length > 0
      $("#email_error").text("#{message.invalid_email}")
    else
      $("#email_error").text("#{message.not_blank}")
    rs = false

  if email == email_conform
    $("#email_confirm_error").removeClass 'error'
    $("#email_confirm_error").addClass 'hidden'
  else
    $("#email_confirm_error").addClass 'error'
    $("#email_confirm_error").removeClass 'hidden'
    rs = false

  if user_password.length > 0
    $("#passwork_error").removeClass 'error'
    $("#passwork_error").addClass 'hidden'
  else
    $("#passwork_error").addClass 'error'
    $("#passwork_error").removeClass 'hidden'
    rs = false

  if user_password == user_password_confirmation
    $("#passwork_confirm_error").removeClass 'error'
    $("#passwork_confirm_error").addClass 'hidden'
  else
    $("#passwork_confirm_error").removeClass 'hidden'
    $("#passwork_confirm_error").addClass 'error'
    rs = false
  return rs

$(".btn_login").live 'click', ->
  email = $("#user_email").val()
  user_password = $("#user_password").val()
  rs = true
  if isEmail(email)
    $("#email_login_error").removeClass 'error'
    $("#email_login_error").addClass 'hidden'
  else
    $("#email_login_error").addClass 'error'
    $("#email_login_error").removeClass 'hidden'
    if email.length > 0
      $("#email_login_error").text("#{message.invalid_email}")
    else
      $("#email_login_error").text("#{message.not_blank}")
    rs = false
  if user_password.length > 0
    $("#passwork_login_error").removeClass 'error'
    $("#passwork_login_error").addClass 'hidden'
  else
    $("#passwork_login_error").addClass 'error'
    $("#passwork_login_error").removeClass 'hidden'
    rs = false
  return rs

