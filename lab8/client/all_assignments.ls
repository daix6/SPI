if Meteor.is-client
  Template.all_assignments.helpers {
    user: -> Session.get "current-user"
    is-student: ->
        user = Session.get "current-user"
        user.identity is "Student"
    is-teacher: ->
        user = Session.get "current-user"
        user.identity is "Teacher"

    assignments: -> Assignment.find!fetch!
    is-not-assignments: ->
      assignments = Assignment.find!fetch!
      assignments.length <= 0
  }

  Template.all_assignments.events {
    'click .zero_post': (ev, tpl)->
        $ (".submit-homework") .css "display" "block"
        $ (".all-assignments") .css "display" "none"

    'click .list-group-item': (ev, tpl)->
        ($ ".single-assignment")[0] .id = ev.target.id
        $ (".single-assignment") .css "display" "block"
        $ (".all-assignments") .css "display" "none"
        $ (".submit-homework") .css "display" "none"
  }