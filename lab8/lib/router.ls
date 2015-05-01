Router.configure {
  layout-template: 'layout',
  loading-template: 'loading',
  not-found-template: 'not_found',
  wait-on: ->
    Meteor.subscribe 'Assignment'
}

Router.route '/', {name: 'assignments_list'}

Router.route '/assignments/:id', {
  name: 'assignment_page',
  data: ->
    Assignment.findOne @.params._id
}

Router.on-before-action 'dataNotFound', {only: 'assignment_page'}
