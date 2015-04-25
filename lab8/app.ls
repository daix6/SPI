root = exports ? @

root.User = new Mongo.Collection 'User'
root.Assignment = new Mongo.Collection 'Assignment'
root.Homework = new Mongo.Collection 'Homework'

Meteor.methods {}

Router.route '/', ->
    $(".form_signup") .css "display" "block"
    $ (".form_register")  .css "display" "none"

Meteor.startup -> if Meteor.is-client
  $ 'form[data-parsley-validate]' .parsley!