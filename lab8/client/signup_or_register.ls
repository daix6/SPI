if Meteor.is-client
  Template.signup_or_register.helpers {
    user: -> Session.get "current-user"
  }

  Template.signup_or_register.events {
    'click .signup_register': (ev, tpl) !->
        $(".form_signup") .css "display" "none"
        $ (".form_register")  .css "display" "block"
        $ "input" .val ""
        ($ "input[name=identity]")[0] .val "Student"
        ($ "input[name=identity]")[1] .val "Teacher"

    'click .register_signup': (ev, tpl)  !->
        $(".form_signup") .css "display" "block"
        $ (".form_register")  .css "display" "none"

    'click .signup_login': (ev, tpl) ->
        username = ($ "input[name=log_username]") .val!
        password = ($ "input[name=log_password]") .val!
        user = User.findOne {username: username, password: password}
        if user then
            Session.set 'current-user', user
            $(".form_signup") .css "display" "none"
            $ (".form_register")  .css "display" "none"
        else
            alert "There is no #{username} or you may have wrong password."

    'click .register_register': (ev, tpl) ->
        username = ($ "input[name=username]") .val!
        password = ($ "input[name=password]") .val!
        name = ($ "input[name=name]") .val!
        email = ($ "input[name=email]") .val!
        for form_identity in ($ "input[name=identity]")
            if form_identity.checked
                identity = form_identity.value
        user = User.findOne {username: username}
        if user then
            alert "There already have #{username}, why not change an username?"
        else
            User.insert user = {username, password, name, email, identity}
            Session.set "current-user", user
            $(".form_signup") .css "display" "none"
            $ (".form_register")  .css "display" "none"

    'click .signout': (ev, tpl) ->
        Session.set "current-user" undefined
        $(".form_signup") .css "display" "block"
        $ (".form_register")  .css "display" "none"
        $ "input" .val ""
  }