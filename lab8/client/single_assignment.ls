if Meteor.is-client
  Template.single_assignment.helpers {
    user: -> Session.get "current-user"
    is-student: ->
        user = Session.get "current-user"
        user.identity is "Student"
    is-teacher: ->
        user = Session.get "current-user"
        user.identity is "Teacher"

    assignment: -> Assignment.findOne {_id: window.location.hash}
  }
