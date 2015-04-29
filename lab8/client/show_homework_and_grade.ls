if Meteor.is-client
  Template.show_homework_and_grade.helpers {
    user: -> Session.get "current-user"
    is-student: ->
        user = Session.get "current-user"
        user.identity is "Student"
    is-teacher: ->
        user = Session.get "current-user"
        user.identity is "Teacher"

    homeworks: -> Homework.find {assignment-id: window.location.hash} .fetch!
  }

  Template.show_homework_and_grade.events {
    'click .give-grade': (ev, tpl)->
  }