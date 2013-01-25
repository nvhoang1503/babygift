class window.Hard
  constructor: ->
    @displayFaqTab()


  displayFaqTab: ->
    $('.fqa_about').live "click", ->
      # $(this).addClass('selected')
      # hightlight selected link
      $('.fqa_about').addClass('selected')
      $('.fqa_sign_up').removeClass('selected')
      $('.fqa_ship_bill').removeClass('selected')
      $('.fqa_gift').removeClass('selected')
      $('.fqa_orther').removeClass('selected')

      # display tab content
      $("#fqa_about_littlespark").removeClass('hidden')
      $("#fqa_signup").addClass('hidden')
      $("#fqa_shipping_billing").addClass('hidden')
      $("#fqa_gifts").addClass('hidden')
      $("#fqa_other").addClass('hidden')

    $('.fqa_sign_up').live "click", ->
      # hightlight selected link
      $('.fqa_about').removeClass('selected')
      $('.fqa_sign_up').addClass('selected')
      $('.fqa_ship_bill').removeClass('selected')
      $('.fqa_gift').removeClass('selected')
      $('.fqa_orther').removeClass('selected')

      # display tab content
      $("#fqa_about_littlespark").addClass('hidden')
      $("#fqa_signup").removeClass('hidden')
      $("#fqa_shipping_billing").addClass('hidden')
      $("#fqa_gifts").addClass('hidden')
      $("#fqa_other").addClass('hidden')

    $('.fqa_ship_bill').live "click", ->
      # hightlight selected link
      $('.fqa_about').removeClass('selected')
      $('.fqa_sign_up').removeClass('selected')
      $('.fqa_ship_bill').addClass('selected')
      $('.fqa_gift').removeClass('selected')
      $('.fqa_orther').removeClass('selected')

      # display tab content
      $("#fqa_about_littlespark").addClass('hidden')
      $("#fqa_signup").addClass('hidden')
      $("#fqa_shipping_billing").removeClass('hidden')
      $("#fqa_gifts").addClass('hidden')
      $("#fqa_other").addClass('hidden')

    $('.fqa_gift').live "click", ->
      # hightlight selected link
      $('.fqa_about').removeClass('selected')
      $('.fqa_sign_up').removeClass('selected')
      $('.fqa_ship_bill').removeClass('selected')
      $('.fqa_gift').addClass('selected')
      $('.fqa_orther').removeClass('selected')

      # display tab content
      $("#fqa_about_littlespark").addClass('hidden')
      $("#fqa_signup").addClass('hidden')
      $("#fqa_shipping_billing").addClass('hidden')
      $("#fqa_gifts").removeClass('hidden')
      $("#fqa_other").addClass('hidden')

    $('.fqa_orther').live "click", ->
      # hightlight selected link
      $('.fqa_about').removeClass('selected')
      $('.fqa_sign_up').removeClass('selected')
      $('.fqa_ship_bill').removeClass('selected')
      $('.fqa_gift').removeClass('selected')
      $('.fqa_orther').addClass('selected')

      # display tab content
      $("#fqa_about_littlespark").addClass('hidden')
      $("#fqa_signup").addClass('hidden')
      $("#fqa_shipping_billing").addClass('hidden')
      $("#fqa_gifts").addClass('hidden')
      $("#fqa_other").removeClass('hidden')


