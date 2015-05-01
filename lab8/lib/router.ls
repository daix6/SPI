Router.configure {
  layout-template: 'layout',
  loading-template: 'loading',
  not-found-template: 'not_found',
  wait-on: ->
    Meteor.subscribe 'Assignment'
}

Router.route '/', {name: 'index'}
Router.route '/signin', {name: 'signin'}
Router.route '/signup', {name: 'signup'}
Router.route '/signout', !->
  Meteor.logout (error) !->
    Router.go '/signin', {name: 'signin'}

Router.route '/assign', {name: 'assign'}
Router.route '/assignments', {name: 'assignmentsList'}
Router.route '/assignments/:url', {
  name: 'assignmentPage',
  data: ->
    Assignment.find-one {url: @.params.url}
}

Router.route '/assignments/:url/homeworks', {
  name: 'homeworksList',
  data: ->
    homeworks = Homework.find {assignment-url: @.params.url} .fetch!
    homeworks
}

require-login = !->
  if !Meteor.user! then
    if Meteor.loggingIn! and Meteor.user!.profile.identity is 'Teacher' then
      @.render @.loading-template
    else
      @.render 'access_denied'
  else
    @.next!

Router.on-before-action 'dataNotFound', {only: 'assignment_page'}
Router.on-before-action require-login, {only: 'assign'}

root = exports ? @
root.Router = Router