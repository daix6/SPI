if Meteor.is-client
  Template.all-assignments.helpers {
    user: -> Session.get "current-user"
  }