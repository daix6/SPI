class Button

    # 存放所有的button
    @buttons = []

    # 类方法
    @disable-other-buttons = (current-button) ->
        [button.disable! for button in @buttons when button isnt current-button and button.state isnt 'done']

    @enable-other-buttons = (current-button) ->
        [button.enable! for button in @buttons when button isnt current-button and button.state isnt 'done' ]

    @all-button-got-number = ->
        [return false for button in @buttons when button.state isnt 'done']
        return true

    @reset-all-buttons = ->
        [button.reset! for button in @buttons]

    # 构造子
    (@dom, @callback-when-got-number) ->
        @state = 'enabled'
        # bound methods, which have their definition of `this` bound to the instance
        @dom.click !~> if @state is 'enabled'
            # ! 立即执行
            @@@disable-other-buttons @ # 传入当前button
            @wait! # wait with "..."
            @get-number-and-show! # 显示拿到的数
        @@@buttons.push @ # 把当前button push到@buttons数组

    # 以下是实例方法，!-> 代表没有返回值
    get-number-and-show: !->
        # 如果这里写 !-> this是Object
        # 变成!~>的话，在这行增加 var this$ = this
        $.get '/', (number) !~>
            # callback
            @done!
            @@@enable-other-buttons @
            @show-number number

    show-number: (number) !->
        @dom.find '.unread' .text number

    disable: !->
        @state = 'disabled'
        @dom.remove-class 'enabled' .add-class 'disabled'

    enable: !->
        @state = 'enabled'
        @dom.remove-class 'disabled' .add-class 'enabled'

    wait: !->
        @state = 'wait'
        @dom.remove-class 'disabled' .add-class 'wait'
        @dom.find '.unread' .text "..."

    done: !->
        @state = 'done'
        @dom.remove-class 'wait' .add-class 'done'

    reset: !->
        @state = 'enabled'
        @dom.remove-class 'disabled wait done' .add-class 'enabled'
        @dom.find '.unread' .text ""

caculator = 
    sum: 0
    add: (number)->
        @sum += parse-int number
    reset: !->
        @sum = 0

$ ->
    add-click-to-get-number-with-ajax-to-all-numbers!

add-click-to-get-number-with-ajax-to-all-numbers = ->
    for let btn in $ '#control-ring .button'
        button = new Button $(btn), (error. number)!->
            if error
                console.log "Handle error from #{button.name}"
                number = error.data
            caculator.add number
