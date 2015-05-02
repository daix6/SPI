get-date-time = ->
  now = new Date!
  year = now.get-full-year!
  month = now.get-month! + 1
  day = now.get-date!
  hour = now.get-hours!
  minute = now.get-minutes!
  year + '-' + month + '-' + day + ' ' + hour + ':' + minute

Template.student-homework.events {
  'submit form': (e)->
    e.preventDefault!

    path = window.location.pathname.split '/'
    url = path[2]

    homework = {
      content: ($ e.target) .find '[name=content]' .val!
      time: get-date-time!
      grade: undefined
      author-id: Meteor.userId!
      author-username: Meteor.user!.username
      author-name: Meteor.user!.profile.name
      assignment-url: url
    }
    Homework.insert homework, (error, id) ->
      if error
        alert error.reason
      else
        Router.go '/assignments/' + url
}