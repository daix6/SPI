Template.assignment_item.helpers {
  domain: ->
    a = document.createElement 'a'
    a.href = @.url
    a.hostname
}