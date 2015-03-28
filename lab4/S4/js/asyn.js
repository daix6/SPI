;window.onload = function() {
    var container = document.getElementById("at-plus-container");
    var lists = document.getElementsByClassName("button");
    var info_bar = document.getElementsByClassName("info")[0];
    var at_plus = document.getElementsByClassName("icon")[0];

    init();

    for (var i = 0; i < lists.length; ++i) {
        addEvent(lists[i], 'click', function(j) {
            return function() {
                getNumber(lists[j]);
            };
        }(i))
    }
    addEvent(info_bar, 'click', showSum);
    addEvent(at_plus, 'click', oneByOne);
    addEvent(container, 'mouseleave', init);
}

function init() {

    var lists = document.getElementsByClassName("button");
    var info_bar = document.getElementsByClassName("info")[0];

    for (var i = 0; i < lists.length; ++i) {
        var span = lists[i].getElementsByTagName("span")[0];
        span.className = removeClass(span, "success");
        lists[i].className = removeClass(lists[i], "disabled");
        lists[i].setAttribute("disabled", false);
    }
    info_bar.innerHTML = "";
}

function disableOthers(element) {
    var lists = document.getElementsByClassName("button");
    for (var i = 0; i < lists.length; ++i) {
        if (lists[i] === element) continue;
        lists[i].className = addClass(lists[i], "disabled");
    }
}

function enableOthers() {
    var lists = document.getElementsByClassName("button");
    for (var i = 0; i < lists.length; ++i) {
        if (lists[i].getAttribute('disabled') === "true") continue;
        lists[i].className = removeClass(lists[i], "disabled");
        lists[i].setAttribute("disabled", false);
    }
}

function allClicked() {
    var lists = document.getElementsByClassName("button");
    for (var i = 0; i < lists.length; ++i) {
        if (lists[i].getAttribute('disabled') === "false")
            return false;
    }
    return true;
}

function getNumber(element) {
    if (!hasClass(element, "disabled")) {
        var red = element.getElementsByTagName("span")[0];
        var request = createRequest();
        request.onreadystatechange = function() {
            if (request.readyState === 4) {
                if (request.status === 200) {
                    red.textContent = request.responseText;
                    element.setAttribute("disabled", true);
                    element.className = addClass(element, "disabled");
                    enableOthers();
                } else {
                    alert('Request was unsuccessful: ' + request.status);
                }
            }
        }
        request.open('GET', '/', 'true');
        request.send(null);
        disableOthers(element);
        red.className = addClass(red, "success");
        red.textContent = "...";
    }
}

function showSum() {
    if (allClicked()) {
        var sum = 0;
        var info_bar = document.getElementsByClassName("info")[0];
        var lists = document.getElementsByClassName("button");
        info_bar.className = removeClass(info_bar, "sequence");

        for (var i = 0; i < lists.length; ++i) {
            var span = lists[i].getElementsByTagName("span")[0];
            sum += parseInt(span.textContent);
        }
        info_bar.innerHTML = sum + "";
        info_bar.setAttribute("disabled", true);
        console.log("test");
    }
}

function clickWhich(c) {
    var lists = document.getElementsByClassName("button");
    switch(c) {
        case 'A':
            lists[0].click();
            break;
        case 'B':
            lists[1].click();
            break;
        case 'C':
            lists[2].click();
            break;
        case 'D':
            lists[3].click();
            break;
        case 'E':
            lists[4].click();
            break;
    }
}

function oneByOne() {
    var origin = ['A', 'B', 'C', 'D', 'E'];
    var sequence = origin.sort(randomSort);
    var info_bar = document.getElementsByClassName("info")[0];
    info_bar.className = addClass(info_bar, "sequence");

    for (var i = 0; i < sequence.length; ++i)
        info_bar.innerHTML += sequence[i] + "";

    clickWhich(sequence[0]);
    setTimeout(function() {
        clickWhich(sequence[1]);
    }, 3000);
    setTimeout(function() {
        clickWhich(sequence[2]);
    }, 6000);
    setTimeout(function() {
        clickWhich(sequence[3]);
    }, 9000);
    setTimeout(function() {
        clickWhich(sequence[4]);
    }, 12000);
    var x = setInterval(function() {
        info_bar.click();
    }, 1000);
    setTimeout(function() {
        clearInterval(x);
    }, 16000);
}

function randomSort(a, b) {
    return Math.random() > 0.5 ? -1 : 1;
}
