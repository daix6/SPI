if Meteor.is-client
  Template.user_info.helpers {
    user: -> Session.get "current-user"
    is-student: ->
        user = Session.get "current-user"
        user.identity is "Student"
    is-teacher: ->
        user = Session.get "current-user"
        user.identity is "Teacher"
  }

  Template.user_info.events {
    'click .signout': (ev, tpl) ->
        Session.set "current-user" undefined
        $(".form_signup") .css "display" "block"
        $ (".form_register") .css "display" "none"
        ($ "input") .val ""
  }