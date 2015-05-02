Template.homeworksList.helpers {
  have-homeworks: ->
    path = window.location.pathname.split '/'
    url = path[2]
    homeworks = Homework.find {assignment-url: url} .fetch!
    homeworks.length > 0
  homeworks: ->
    path = window.location.pathname.split '/'
    url = path[2]
    homeworks = Homework.find {assignment-url: url} .fetch!
    homeworks
}
