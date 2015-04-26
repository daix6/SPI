root = exports ? @

root.User = new Mongo.Collection 'User'
root.Assignment = new Mongo.Collection 'Assignment'
root.Homework = new Mongo.Collection 'Homework'

Meteor.methods {}

Router.route '/', ->
    Session.set "current-user" undefined

Meteor.startup ->