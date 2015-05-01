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
Router.route '/singout', !->
  Meteor.logout !->
    Router.go '/signin'

Router.route '/assignments/:id', {
  name: 'assignment_page',
  data: ->
    Assignment.find-one @.params._id
}

Router.on-before-action 'dataNotFound', {only: 'assignment_page'}

root = exports ? @
root.Router = Router