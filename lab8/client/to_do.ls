if Meteor.is-client
  Template.to_do.helpers {
    user: -> Session.get "current-user"
    is-student: ->
        user = Session.get "current-user"
        user.identity is "Student"
    is-teacher: ->
        user = Session.get "current-user"
        user.identity is "Teacher"
  }

  Template.to_do.events {
    'click .post-assignment': (ev, tpl)->
        $ (".form_post") .css "display" "block"
        $ (".all-assignments") .css "display" "none"

    'click .show-all-assignments': (ev, tpl)->
        $ (".all-assignments") .css "display" "block"
        $ (".form_post") .css "display" "none"
  }
