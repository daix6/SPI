if Meteor.is-client
  Template.to_do.helpers {
    user: -> Session.get "current-user"
  }

  Template.to_do.events {
    '.click .post-assignment': (ev, tpl)->
        $ (".form_post") .css "display" "block"
        $ (".all-assignments") .css "display" "none"

    '.click .all-assignments': (ev, tpl)->
        $ (".all-assignments") .css "display" "block"
        $ (".form_post") .css "display" "none"
  }
