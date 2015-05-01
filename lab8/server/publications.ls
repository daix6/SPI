Meteor.publish 'Assignment', ->
  Assignment.find!

Meteor.publish 'Homework', ->
  Assignment.find!