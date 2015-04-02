// Generated by LiveScript 1.3.1
(function(){
  var Button, calcuator, addClickToGetNumberWithAjaxToAllNumbers, addClickToCalculateSumOfAllButtonsAndShow, addResetToLeaveAtPlusArea, reset, s1WaitingUserClick;
  Button = (function(){
    Button.displayName = 'Button';
    var prototype = Button.prototype, constructor = Button;
    Button.buttons = [];
    Button.disableOtherButtons = function(currentButton){
      var i$, ref$, len$, button, results$ = [];
      for (i$ = 0, len$ = (ref$ = this.buttons).length; i$ < len$; ++i$) {
        button = ref$[i$];
        if (button !== currentButton && button.state !== 'done') {
          results$.push(button.disable());
        }
      }
      return results$;
    };
    Button.enableOtherButtons = function(currentButton){
      var i$, ref$, len$, button, results$ = [];
      for (i$ = 0, len$ = (ref$ = this.buttons).length; i$ < len$; ++i$) {
        button = ref$[i$];
        if (button !== currentButton && button.state !== 'done') {
          results$.push(button.enable());
        }
      }
      return results$;
    };
    Button.allButtonGotNumber = function(){
      var i$, ref$, len$, button;
      for (i$ = 0, len$ = (ref$ = this.buttons).length; i$ < len$; ++i$) {
        button = ref$[i$];
        if (button.state !== 'done') {
          return false;
        }
      }
      $('#info-bar').removeClass('disabled').addClass('enabled');
      return true;
    };
    Button.resetAllButtons = function(){
      var i$, ref$, len$, button, results$ = [];
      for (i$ = 0, len$ = (ref$ = this.buttons).length; i$ < len$; ++i$) {
        button = ref$[i$];
        results$.push(button.reset());
      }
      return results$;
    };
    function Button(dom, callback){
      var this$ = this;
      this.dom = dom;
      this.callback = callback;
      this.state = 'enabled';
      this.request;
      this.dom.click(function(){
        if (this$.state === 'enabled') {
          this$.constructor.disableOtherButtons(this$);
          this$.wait();
          this$.getNumberAndShow();
        }
      });
      this.constructor.buttons.push(this);
    }
    prototype.getNumberAndShow = function(){
      var this$ = this;
      this.request = $.get('/', function(number){
        this$.done();
        this$.constructor.allButtonGotNumber();
        this$.callback(number);
        this$.constructor.enableOtherButtons(this$);
        this$.showNumber(number);
      });
    };
    prototype.showNumber = function(number){
      this.dom.find('.unread').text(number);
    };
    prototype.disable = function(){
      this.state = 'disabled';
      this.dom.removeClass('enabled').addClass('disabled');
    };
    prototype.enable = function(){
      this.state = 'enabled';
      this.dom.removeClass('disabled').addClass('enabled');
    };
    prototype.wait = function(){
      this.state = 'wait';
      this.dom.removeClass('disabled').addClass('wait');
      this.dom.find('.unread').text("...");
    };
    prototype.done = function(){
      this.state = 'done';
      this.dom.removeClass('wait').addClass('done');
    };
    prototype.reset = function(){
      this.state = 'enabled';
      if (this.request) {
        this.request.abort();
      }
      this.dom.removeClass('disabled wait done').addClass('enabled');
      this.dom.find('.unread').text('');
    };
    return Button;
  }());
  calcuator = {
    sum: 0,
    add: function(number){
      return this.sum += parseInt(number);
    },
    reset: function(){
      this.sum = 0;
    }
  };
  $(function(){
    addClickToGetNumberWithAjaxToAllNumbers();
    addClickToCalculateSumOfAllButtonsAndShow();
    addResetToLeaveAtPlusArea();
    return s1WaitingUserClick();
  });
  addClickToGetNumberWithAjaxToAllNumbers = function(){
    var i$, ref$, len$, results$ = [];
    for (i$ = 0, len$ = (ref$ = $('#control-ring .button')).length; i$ < len$; ++i$) {
      results$.push((fn$.call(this, ref$[i$])));
    }
    return results$;
    function fn$(btn){
      var button;
      return button = new Button($(btn), function(number){
        calcuator.add(number);
      });
    }
  };
  addClickToCalculateSumOfAllButtonsAndShow = function(){
    var bigBubble;
    bigBubble = $('#info-bar');
    bigBubble.addClass('disabled');
    return bigBubble.click(function(){
      if (bigBubble.hasClass('enabled')) {
        bigBubble.find('.info').text(calcuator.sum);
      }
    });
  };
  addResetToLeaveAtPlusArea = function(){
    $('#at-plus-container').on('mouseleave', function(){
      reset();
    });
  };
  reset = function(){
    var bigBubble;
    bigBubble = $('#info-bar');
    calcuator.reset();
    Button.resetAllButtons();
    bigBubble.removeClass('enabled').addClass('disabled');
    bigBubble.find('.info').text('');
  };
  s1WaitingUserClick = function(){
    console.log("wait user click...");
  };
}).call(this);
