class window.Helper
  constructor: ->
    @autoHideFlash()

  autoHideFlash: ->
    func =-> $('#flash-panel').fadeOut('slow')
    window.setTimeout func, 10000

  validateZip: (event) ->
    reg = /^\d{0,5}(-\d{0,4})?$/
    return true unless event.charCode
    part1 = @.value.substring 0, @.selectionStart
    part2 = @.value.substring @.selectionEnd, @.value.length
    return reg.test(part1 + String.fromCharCode(event.charCode) + part2)

  validateEmail: (event) ->
    reg = /^([a-zA-Z0-9_@\.])$/
    return true unless event.charCode
    return reg.test(String.fromCharCode(event.charCode))


  isEmail: (email) ->
    regex = /^([a-zA-Z0-9_\.])+\@(([a-zA-Z0-9])+\.)+([a-zA-Z0-9]{2,4})+$/
    if email.indexOf('..') > 0 or email.indexOf('.@') > 0
      return false
    return regex.test(email)

  validatePhone: (event) ->
    # reg need cover other special characters
    # reg = /^[-,\d,\s]$/i
    reg = /^[\d]$/i
    return true unless event.charCode
    return reg.test(String.fromCharCode(event.charCode))

  validateCvv: (event) ->
    reg = /^\d{0,4}?$/
    return true unless event.charCode
    part1 = @.value.substring 0, @.selectionStart
    part2 = @.value.substring @.selectionEnd, @.value.length
    return reg.test(part1 + String.fromCharCode(event.charCode) + part2)

  showErrorMessage: (condit_value , elem ,msg_text, cl = '') ->
    if !condit_value
      if $(elem).siblings('.error').length == 0
        s = "<span class='error #{cl}'>#{msg_text}</span>"
        $(elem).after(s)
      else
        $(elem).siblings('.error').text("#{msg_text}")
      return false
    else
      $(elem).siblings('.error').remove()
      return true

  showFlashMessage: (text) ->
    if $('#flash-panel').find('.alert-box').length == 0
      $('#flash-panel').append("<div class='page_content_space alert-box'>#{text}</div>")
    else
      $('#flash-panel .alert-box').text("#{text}")
      $('#flash-panel').fadeIn()
      @autoHideFlash()

  checkTermsNConditions: (cb_terms, callback) ->
    if $(cb_terms).is(':checked')
      @showErrorMessage(true,'.signup_box',message.term_missing, 'term_error' )
      return callback()
    else
      @showErrorMessage(false,'.signup_box',message.term_missing, 'term_error' )
      return false

  changePlanOnClick: (target) ->
    target = $(target)
    target = target.closest('.icon-plan') if target.hasClass('price')
    $('.icon-plan').not(target).removeClass('selected')
    target.addClass('selected')
    rad = target.closest('span').find('input:radio')
    rad.prop('checked', true)
    $('input:radio').not(rad).prop('checked', false)

  initCvvPopup: ->
    img = '<img src="/assets/common/cvv.png" alt="Cvv">'
    $('#cvv-popup').popover
      title: null
      html: 'true'
      content: img
      trigger: 'hover'

  initTermsNConditionsPopup: ->
    $('#terms_content').live "click", ->
      $('#terms_popup_content').modal
        closeHTML:
          "<div>
            <a class='modalCloseImg' href='#for_module' title='Close' onclick=\"$('.popup_content .no').trigger('click')\" style='color:#000 !important'>
              <img src='/assets/common/closebox.png' width='24px' height='24px' alt='X'>
            </a>
          </div>"
        position: [ "10%" ]
        focus: false
        persist: true
        maxWidth: "740px"
        minWidth: "700px"
        overlayCss:
          backgroundColor:"#121212"

        onShow: (dialog) ->
            $('.popup_content .yes').click ->
              # to do ...
            $('.popup_content .no').click ->
              $.modal.close()

        onClose: (dialog) ->
          $.modal.close()
      return

  initDatepicker: (elem) ->
    $(elem).datepicker({
      format: 'mm/dd/yyyy'
      weekStart: 1
      autoclose: true
      todayHighlight: true
      startView: 0
    }).on 'changeDate', ->
      if $.trim($(elem).val()) != ''
        $("#{elem} ~ label.inputHintOverlay").css({display:'none'})
        func =-> $(elem).focusout()
        window.setTimeout(func, 100)
