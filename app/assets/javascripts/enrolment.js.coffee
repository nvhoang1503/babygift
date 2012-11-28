$ ->
  $('#child-register').inputHintOverlay()
  $('#child_birthday').datepicker({
    format: 'mm/dd/yyyy'
    weekStart: 1
    autoclose: true
    todayHighlight: true
  }).on 'changeDate', ->
    if $('#child_birthday').val().trim() != ''
      $('#child_birthday ~ label.inputHintOverlay').css({display:'none'})
