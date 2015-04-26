if Meteor.is-client
  Template.show_homework_and_grade.helpers {
    user: -> Session.get "current-user"

    homeworks: -> Homework.find {assignment-id: window.location.hash} .fetch!
  }

  Template.show_homework_and_grade.events {
    'click .give-grade': (ev, tpl)->
  }