if Meteor.is-client
  Template.to_do.helpers {
    user: -> Session.get "current-user"
  }
