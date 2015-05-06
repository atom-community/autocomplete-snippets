module.exports =
class SnippetsProvider
  selector: '*'

  constructor: ->
    @showIcon = atom.config.get('autocomplete-plus.defaultProvider') is 'Symbol'

  getSuggestions: ({scopeDescriptor, prefix}) ->
    return unless prefix?.length
    scopeSnippets = atom.config.get('snippets', {scope: scopeDescriptor})
    @findSuggestionsForPrefix(scopeSnippets, prefix)

  findSuggestionsForPrefix: (snippets, prefix) ->
    return [] unless snippets?

    for __, snippet of snippets when snippet.prefix.lastIndexOf(prefix, 0) isnt -1
      iconHTML: if @showIcon then undefined else false
      type: 'snippet'
      text: snippet.prefix
      replacementPrefix: prefix
      rightLabel: snippet.name
      description: snippet.description
      descriptionMoreURL: snippet.descriptionMoreURL

  onDidInsertSuggestion: ({editor}) ->
    atom.commands.dispatch(atom.views.getView(editor), 'snippets:expand')
