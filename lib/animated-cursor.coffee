module.exports = AnimatedCursor =
  config:
      animationDirection:
          type: 'string'
          default: 'vertical'
          enum: ['vertical', 'horizontal']

  activate: (state) ->
    atom.workspace.observeTextEditors @initEditor
    atom.config.onDidChange 'animated-cursor.animationDirection', @updateDirection

  deactivate: ->

  serialize: ->

  initEditor: (textEditor) ->
      direction = atom.config.get 'animated-cursor.animationDirection'
      textEditorView = atom.views.getView textEditor
      for cursors in textEditorView.shadowRoot.querySelectorAll '.cursors'
          cursors.classList.add 'animated-cursor'
          cursors.classList.add 'animated-cursor-' + direction

  updateDirection: (event) ->
      for textEditor in atom.workspace.getTextEditors()
          textEditorView = atom.views.getView textEditor
          for cursors in textEditorView.shadowRoot.querySelectorAll '.cursors'
              cursors.classList.remove 'animated-cursor-' + event.oldValue
              cursors.classList.add 'animated-cursor-' + event.newValue
