require! {"express", Assignment:"../models/assignment"}
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
    
    console.log Assignment
    new-assignment = new Assignment!
    new-assignment.title = req.param "title"
    new-assignment.description = req.param "description"
    new-assignment.deadline = req.param "deadline"
    new-assignment.teacherId = req.user._id
    console.log "1"
    new-assignment.save (err)->
      console.log "2"
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

  router.get "/assignments/:id", is-authenticated, (req, res)!->
    assignment-id = req.params.id # route的属性
    console.log assignment-id
    Assignment.find-by-id assignment-id, (err, doc)!->
      if err
        console.log "找不到这个id的作业"
      else
        console.log doc
        out-of-date = true
        res.render "singleAss", {homework: doc, user: req.user, out-of-date: out-of-date}
