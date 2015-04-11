require! {"express", Assignment:"../models/assignment", Homework:"../models/homework", fs}
router = express.Router! 

is-authenticated = (req, res, next)-> if req.is-authenticated! then next! else res.redirect "/"

module.exports = (passport)->
  router.get "/", (req, res)!-> res.render "index", message: req.flash "message"

  router.post "/login", passport.authenticate "login", {
    success-redirect: "/home", failure-redirect: "/", failure-flash: true
  }

  router.get "/signup", (req, res)!-> res.render "register", message: req.flash "message"

  router.post "/signup", passport.authenticate "signup", {
    success-redirect: "/home", failure-redirect: "/signup", failure-flash: true
  }

  router.get "/home", is-authenticated, (req, res)!-> res.render "home", user: req.user

  router.get "/signout", (req, res)!-> 
    req.logout!
    res.redirect "/"

  router.get "/assign", is-authenticated, (req, res)!->
    res.render "assign", user: req.user

  router.post "/assign", is-authenticated, (req, res)!->
    new-assignment = new Assignment!
    new-assignment.title = req.param "title"
    new-assignment.description = req.param "description"
    new-assignment.deadline = Date.parse new Date req.param "deadline".replace("T")
    new-assignment.teacherId = req.user._id
    new-assignment.save (err)->
      if err
        console.log "保存作业时出错啦: ", err
      else
        Assignment.find-by-id new-assignment, (err, doc)!->
          # doc 是查询结果
          if err
            console.log "跳转到作业页面出错！"
          else
            res.redirect "/assignments/" + doc._id

  router.get "/assignments", is-authenticated, (req, res)!->
    if req.user.identity is "1"
      Assignment.find (err, all-assignments) !->
        if err
          console.log "查询所有作业有误！"
        res.render "manyAss", {assignments: all-assignments, user: req.user}
    else
      Assignment.find {teacherId: req.user._id} (err, this-teacher-assignments)!->
        if err
          console.log "查询该老师发布的作业有误"
        res.render "manyAss", {assignments: this-teacher-assignments, user: req.user}

  router.get "/assignments/:id/:hwid?", is-authenticated, (req, res)!->
    if !req.params.hwid
      assignment-id = req.params.id # route的属性
      Assignment.find-by-id assignment-id, (err, doc)!->
        if err
          console.log "找不到这个id的作业"
        else
          Homework.find {assignmentId: assignment-id} (err, all-homeworks)!->
            if err
              console.log "拿所有作业时错误"
            out-of-date = false
            res.render "singleAss", {assignment: doc, homeworks: all-homeworks, user: req.user, out-of-date: out-of-date}
    else
      console.log "here"
      console.log req.params.hwid
      Homework.find-one {_id: req.params.hwid}, (err, doc)!->
        if err
          console.log "拿出作业时错误"
        res.render "homework", {homework: doc, user: req.user}

  router.post "/post", is-authenticated, (req, res)!->
    Homework.find-one {assignmentId: req.param "assignment_id", studentId: req.user._id}, (err, doc)!->
      if doc
        Homework.update {_id: doc._id}, {$set: {text: req.param("hw"), postDate: Date.parse(new Date!), grade: -1}}, (err)!->
          if err
            console.log "更新作业时发生错误"
      else
        new-homework = new Homework!
        new-homework.assignmentId = req.param "assignment_id"
        new-homework.assignmentTitle = req.param "assignment_title"
        new-homework.studentId = req.user._id
        new-homework.studentName = req.user.lastName + req.user.firstName
        new-homework.text = req.param "text"
        new-homework.save (err)->
          if err
            console.log "保存作业时出错"

    Homework.find-one {assignmentId: req.param("assignment_id"), studentId: req.user._id}, (err, doc)!->
      if err
        console.log "跳转到作业页面出错！", err
      res.redirect "/assignments/" + doc.assignmentId + "/" + doc._id

  router.post "/grade", is-authenticated, (req, res)!->
    console.log req.param "homework_id"
    Homework.update {_id: req.param "homework_id"}, {$set: {grade: req.param "grade"}}, (err)->
      if err
        console.log "err", err
      res.redirect "/assignments/" + doc.assignmentId