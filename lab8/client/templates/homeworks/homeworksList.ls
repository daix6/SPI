Template.homeworksList.helpers {
  have-homeworks: ->
    t-homeworks.length > 0
  homeworks: ->
    t-homeworks
}

t-path = window.location.pathname.split '/'
t-url = t-path[2]
t-homeworks = Homework.find {assignment-url: t-url} .fetch!