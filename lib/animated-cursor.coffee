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
    textEditorView = atom.views.getView textEditor

    if textEditorView.shadowRoot
        shadowEditor = textEditorView.shadowRoot.querySelector('.editor--private')
        classList = shadowEditor.classList
    else
        classList = textEditorView.classList

    classList.add 'animated-cursor' unless classList.contains 'animated-cursor'
    classList.add 'animated-cursor-' + direction

  updateDirection: (event) ->
    for textEditor in atom.workspace.getTextEditors()
      textEditorView = atom.views.getView textEditor

      if textEditorView.shadowRoot
          classList = textEditorView.shadowRoot.querySelector('.editor--private')
      else
          classList = textEditorView.classList

      classList.remove 'animated-cursor-' + event.oldValue
      classList.add 'animated-cursor-' + event.newValue
