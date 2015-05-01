Template.assignmentsList.helpers {
  assignments: ->
    Assignment.find!.fetch!
  have-assignments: ->
    Assignment.find!.fetch!.length > 0
}