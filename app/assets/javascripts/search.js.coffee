(($) ->
  class @AdvancedSearch
    constructor: (@templates = {}) ->

    add_fields: (button, type, content) ->
      new_id = new Date().getTime()
      regexp = new RegExp('new_' + type, 'g')
      $(button).closest('p').before(content.replace(regexp, new_id))

    remove_fields: (button) ->
      container = $(button).closest('.fields')
      if (container.siblings().length > 1)
        container.remove()
      else
        container.parent().closest('.fields').remove()

  $(document).ready ->
    advanced_search = new AdvancedSearch()

    $(".add_fields").live "click", ->
      advanced_search.add_fields this, $(this).data("fieldType"), $(this).data("content")
      false

    $(".remove_fields").live "click", ->
      advanced_search.remove_fields this
      false

    $("select.predicate").live "change", ->
      value_el = $('input#' + $(this).attr('id').slice(0, -1) + "v_0_value");
      if $(this).val() in ["true", "false", "blank", "present", "null", "not_null"]
        value_el.val("true")
        value_el.hide()
      else
        unless value_el.is(":visible")
          value_el.val("")
          value_el.show()

    # show spinner and disable the form when the search is underway
    $("#advanced_search form input:submit").live "click", ->
      $("#loading").show();
      $("#advanced_search").css({ opacity: 0.4 });
      $('div.list').html('')
      true

    # Fire change event for existing search form.
    $("select.predicate").change()

) jQuery
