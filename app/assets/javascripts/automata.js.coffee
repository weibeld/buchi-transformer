# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('a[data-send]').click (e) ->
    e.preventDefault()

    switch $(this).attr('data-send')
      when 'random'
        $.post '/automata/random'
      when 'draw-1'
        $.post '/automata/draw',
          side: 1,
          yaml: editor_1.getValue()
      when 'draw-2'
        $.post 'automata/draw',
          side: 2,
          yaml: editor_2.getValue()
      when 'transform'
        $.post 'automata/transform',
          algo: $("#transform-selection").val(),
          yaml: editor_1.getValue()

  editor_1 = ace.edit("editor-1")
  editor_2 = ace.edit("editor-2")
  for editor in [editor_1, editor_2]
    editor.setTheme("ace/theme/monokai")
    editor.getSession().setMode("ace/mode/yaml")
    editor.getSession().setTabSize(2)
    editor.setShowPrintMargin(false);
  
      