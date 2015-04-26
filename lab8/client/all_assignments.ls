if Meteor.is-client
  Template.all_assignments.helpers {
    user: -> Session.get "current-user"

    assignments: -> Assignment.find!fetch!
  }

  Template.all_assignments.events {
    'click .zero_post': (ev, tpl)->
        $ (".submit-homework") .css "display" "block"
        $ (".all-assignments") .css "display" "none"

    'click .list-group-item': (ev, tpl)->
        $ (".single-assignment") .css "display" "block"
        $ (".all-assignments") .css "display" "none"
  }