if Meteor.is-client
  Template.post_assignment.helpers {
    user: -> Session.get "current-user"
    is-student: ->
        user = Session.get "current-user"
        user.identity is "Student"
    is-teacher: ->
        user = Session.get "current-user"
        user.identity is "Teacher"
  }

  Template.post_assignment.events {
    'click .assign-post': (ev, tpl)->
      title = ($ "input[name=assign_title]") .val!
      description = ($ "input[name=assign_description]") .val!
      deadline = ($ "input[name=assign_deadline]") .val!
      requirement = ($ "input[name=assign_require]") .val!
      Assignment.insert ass = {title, description, deadline, requirement}
      ($ ".form_post") .css "display" "none"
      ($ ".all-assignments") .css "display" "block"
  }