require! {'express', Assignment:'../models/assignment'}
router = express.Router! 

is-authenticated = (req, res, next)-> if req.is-authenticated! then next! else res.redirect '/'

to-timestamp = (string)->
  date = string.split 'T' [0]
  time = string.split 'T' [1]
  hour = time.split '%3A' [0]
  minute = time.split '%3A' [1]
  data + " " + hour + ":" + minute

module.exports = (passport)->
  router.get '/', (req, res)!-> res.render 'index', message: req.flash 'message'

  router.post '/login', passport.authenticate 'login', {
    success-redirect: '/home', failure-redirect: '/', failure-flash: true
  }

  router.get '/signup', (req, res)!-> res.render 'register', message: req.flash 'message'

  router.post '/signup', passport.authenticate 'signup', {
    success-redirect: '/home', failure-redirect: '/signup', failure-flash: true
  }

  router.get '/home', is-authenticated, (req, res)!-> res.render 'home', user: req.user

  router.get '/signout', (req, res)!-> 
    req.logout!
    res.redirect '/'

  router.get '/homeworks', is-authenticated, (req, res)!->
    res.render 'homeworks', user: req.user, homeworks: homeworks

  router.get '/assign', is-authenticated, (req, res)!->
    res.render 'assign', user: req.user

  router.post '/assign', is-authenticated, (req, res)!->
    new-assignment = new Assignment {
      title       : req.param 'title'
      description : req.param 'description'
      deadline    : req.param 'deadline'
      teacherId   : req.user._id
    }
    new-assignment.save (err)->
      if err
        console.log "保存作业时出错啦: ", err
        throw err
      else
        Assignment.find-by-id new-assignment, (err, doc)!->
          # doc 是查询结果
          if err
            console.log "跳转到作业页面出错！"
          res.redirect '/assignment/' + doc._id

  router.get '/assignments', is-authenticated, (req, res)!->
    if req.user.identity is "1"
      Assignment.find (err, all-assignments) !->
        if err
          console.log "查询所有作业有误！"
        res.render 'assignments', {assignments: all-assignments, user: req.user}
    else
      Assignment.find {teacherId: req.user._id} (err, this-teacher-assignments)!->
        if err
          console.log "查询该老师发布的作业有误"
        res.render 'assignments', {assignments: this-teacher-assignments, user: req.user}

  router.get '/assignment/:id', is-authenticated, (req, res)!->
    assignment-id = req.param.id # route的属性
    Assignment.find-by-id assignment-id, (err, doc)!->
      if err
        console.log "找不到这个id的作业"
      out-of-date = true
      res.render 'assignment', {homework: doc, user: req.user, out-of-date: out-of-date}
