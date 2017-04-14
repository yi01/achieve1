ready = ->
  $(window).scroll ->
    element = $('#page-top-btn-blog')
    visible = element.is(':visible')
    height = $(window).scrollTop()
    if height > 100
      element.fadeIn() if !visible
    else
      element.fadeOut()
  $(document).on 'click', '#move-page-top-blog', ->
    $('html, body').animate({ scrollTop: 0 }, 'slow')

$(document).ready(ready)
$(document).on('page:load', ready)
