window.onload = function() {
    var tables = getAllTables();
    makeAllTablesSortable(tables);
}

function getAllTables() {
    var tables = document.getElementsByTagName('table');
    return tables;
}

function makeAllTablesSortable(tables) {
    for (var i = 0; i < tables.length; ++i) {
        sortSingleTable(tables[i]);
    }
}

function sortSingleTable(table) {
    var th = table.getElementsByTagName('th');

    for (var i = 0; i < th.length; i++) {
        addEvent(th[i], 'click', function(j) { return function() { sortColumn(j, table, sortWay(th[j])); }; }(i));
    }
}

function addEvent(element, event, handler) {
    if (element.addEventListener) {
        element.addEventListener(event, handler, false);
    } else {
        element.attachEvent('on' + event, handler);
    }
}

function sortWay(th) {
/* th：需要排序的列的th
 */
    var ascend = true, descend = false;
    var th_class = th.className;

    var ths = document.getElementsByTagName('th');
    for (var i = 0; i < ths.length; i++) {
        ths[i].className = ths[i].className.replace( /(?:^|\s)ascend(?!\S)/g, '' );
        ths[i].className = ths[i].className.replace( /(?:^|\s)descend(?!\S)/g, '' );
    }

    th.className = th_class;

    if (th.className.match(/(?:^|\s)ascend(?!\S)/)) {
        th.className = th.className.replace( /(?:^|\s)ascend(?!\S)/g, 'descend' );
        return descend;
    } else if (th.className.match( /(?:^|\s)descend(?!\S)/ )) {
        th.className = th.className.replace( /(?:^|\s)descend(?!\S)/g, 'ascend' );
        return ascend;
    } else {
        th.className += "ascend";
        return ascend;
    }
}


function sortColumn(col, rows, way) {
/* col: 根据此列排序
 * rows: 需要排序的所有列
 * way: 排序方式（true：升序，false：降序）
 */
if (way) {
        
    } else {

    }
}
