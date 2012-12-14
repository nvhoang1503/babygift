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

  validatePhone: (event) ->
    # reg need cover other special characters
    reg = /^[a-z]$/i
    return true unless event.charCode
    return !reg.test(String.fromCharCode(event.charCode))

  validateCvv: (event) ->
    reg = /^\d{0,4}?$/
    return true unless event.charCode
    part1 = @.value.substring 0, @.selectionStart
    part2 = @.value.substring @.selectionEnd, @.value.length
    return reg.test(part1 + String.fromCharCode(event.charCode) + part2)

  checkTermsNConditions: (cb_terms, callback) ->
    if $(cb_terms).is(':checked')
      return callback()
    else
      if $('#flash-panel').find('.alert-box').length == 0
        $('#flash-panel').append('<div class="page_content_space alert-box">You must agree the terms and conditions</div>')
      else
        $('#flash-panel .alert-box').text('You must agree the terms and conditions')
        $('#flash-panel').fadeIn()
        @autoHideFlash()
      return false
