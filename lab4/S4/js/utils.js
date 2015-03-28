function addEvent(element, event, handler) {
    if (element.addEventListener) {
        element.addEventListener(event, handler, false);
    } else if (element.attachEvent) {
        // for IE 8-
        element.attachEvent('on' + event, handler);
    } else {
        element['on' + event] = handler;
    }
}

function createRequest() {
    var request;
    if (window.XMLHttpRequest) {
        request = new XMLHttpRequest();
    } else {
        request = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return request;
}

function hasClass(element, classname) {
    return element.className.indexOf(classname) === -1 ? false : true;
}

function removeClass(element, classname) {
    if (hasClass(element, classname)) {
        return element.className.replace(classname, "");
    } else {
        return element.className;
    }
}

function addClass(element, classname) {
    if (!hasClass(element, classname)) {
        return element.className += " " + classname;
    } else {
        return element.className;
    }
}
