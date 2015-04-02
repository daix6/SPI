;window.onload = function() {
    var container = document.getElementById("at-plus-container");
    var lists = document.getElementsByClassName("button");
    var info_bar = document.getElementsByClassName("info")[0];

    init();

    for (var i = 0; i < lists.length; ++i) {
        addEvent(lists[i], 'click', function(j) {
            return function() {
                getNumber(lists[j]);
            };
        }(i))
    }
    addEvent(info_bar, 'click', showSum);
}

function getRequest(request, element) {
    if (request) {
        var container = document.getElementById("at-plus-container");
        if (!container.hasMouseleave) {
            addEvent(container, 'mouseleave', reset(request));
            container.hasMouseleave = true;
        }
    }
}

function reset(request) {
    return function() {
        request.abort();
        init();
    }
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
        getRequest(request, element);
    }
}


function showSum() {
    if (allClicked()) {
        var sum = 0;
        var info_bar = document.getElementsByClassName("info")[0];
        var lists = document.getElementsByClassName("button");
        for (var i = 0; i < lists.length; ++i) {
            var span = lists[i].getElementsByTagName("span")[0];
            sum += parseInt(span.textContent);
        }
        info_bar.innerHTML = sum + "";
    }
}
