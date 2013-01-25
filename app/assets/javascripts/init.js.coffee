$ ->
  window.helper = new Helper
  window.enroll = new Enrolment if window.Enrolment
  window.gift = new Gift if window.Gift
  window.redeem = new Redeem if window.Redeem
  window.register = new Register if window.Register
  window.user = new User if window.User
  window.hard = new Hard if window.Hard


# Fix for browser compatibility
$(document).ready ->
  if $.browser.mozilla == true
    $('body').addClass('mozilla')
  if $.browser.chrome == true
    $('body').addClass('chrome')
  if $.browser.safari == true
    $('body').addClass('safari')
  if $.browser.msie == true
    $('body').addClass('msie')
