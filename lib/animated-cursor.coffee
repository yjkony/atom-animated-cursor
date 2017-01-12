module.exports = AnimatedCursor =
  config:
    animationDirection:
      type: 'string'
      default: 'vertical'
      enum: ['vertical', 'horizontal']

  activate: (state) ->
    atom.workspace.observeTextEditors @init
    atom.config.onDidChange 'animated-cursor.animationDirection', @updateDirection

  deactivate: ->

  serialize: ->

  init: (textEditor) ->
    direction = atom.config.get 'animated-cursor.animationDirection'
    AnimatedCursor.setEditor textEditor, direction

  updateDirection: (event) ->
    for textEditor in atom.workspace.getTextEditors()
      AnimatedCursor.setEditor textEditor, event.newValue, event.oldValue

  setEditor: (textEditor, newValue, oldValue) ->
      textEditorView = atom.views.getView textEditor
      classList = textEditorView.classList
      classList.add 'animated-cursor' unless classList.contains 'animated-cursor'
      classList.remove 'animated-cursor-' + oldValue if oldValue
      classList.add 'animated-cursor-' + newValue
