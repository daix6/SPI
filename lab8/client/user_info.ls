if Meteor.is-client
  Template.user_info.helpers {
    user: -> Session.get "current-user"
  }