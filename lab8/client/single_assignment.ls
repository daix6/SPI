if Meteor.is-client
  Template.single_assignment.helpers {
    user: -> Session.get "current-user"

    assignment: -> Assignment.findOne {_id: window.location.hash}
  }
