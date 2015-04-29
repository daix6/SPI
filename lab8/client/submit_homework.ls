if Meteor.is-client
  Template.submit_homework.helpers {
    user: -> Session.get "current-user"

    assignment-id: -> window.location.hash

    homework: -> Homework.findOne {username: Session.get "current-user", assignment-id: window.location.hash}
  }

  Template.submit_homework.events {
    'click .update-homework': (ev, tpl) !->
      ($ "update-homework-form") .css "display" "block"

    'click .submit-homework-btn': (ev, tpl) ->

    'click .update-homework-btn': (ev, tpl) ->
  }