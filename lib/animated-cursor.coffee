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
    shadowEditor = textEditorView.shadowRoot.querySelector('.editor--private')
    shadowEditor.classList.add 'animated-cursor' unless shadowEditor.classList.contains 'animated-cursor'
    shadowEditor.classList.add 'animated-cursor-' + direction

  updateDirection: (event) ->
    for textEditor in atom.workspace.getTextEditors()
      textEditorView = atom.views.getView textEditor
      shadowEditor = textEditorView.shadowRoot.querySelector('.editor--private')
      shadowEditor.classList.remove 'animated-cursor-' + event.oldValue
      shadowEditor.classList.add 'animated-cursor-' + event.newValue
