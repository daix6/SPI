// init
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
        // bind events to the head of table
        addEvent(th[i], 'click', function(j) { return function() { sortColumn(j, table, sortWay(th[j])); }; }(i));
        // use closure to avoid the i will always be referred as th.length
    }
}

function addEvent(element, event, handler) {
    if (element.addEventListener) {
        element.addEventListener(event, handler, false);
    } else {
        // for IE 8-
        element.attachEvent('on' + event, handler);
    }
}

// judge the sortting way
function sortWay(th) {
    var ascend = true, descend = false;
    var th_class = th.className; // for save

    // init by removing special classname('ascend' and 'descend')
    var ths = document.getElementsByTagName('th');
    for (var i = 0; i < ths.length; ++i) {
        ths[i].className = ths[i].className.replace( /(?:^|\s)ascend(?!\S)/g, '' );
        ths[i].className = ths[i].className.replace( /(?:^|\s)descend(?!\S)/g, '' );
    }


    th.className = th_class;

    // for different cases
    if (th.className.match(/(?:^|\s)ascend(?!\S)/)) {
        th.className = th.className.replace( /(?:^|\s)ascend(?!\S)/g, '' );
        th.className += ' descend';
        return descend;
    } else if (th.className.match( /(?:^|\s)descend(?!\S)/ )) {
        th.className = th.className.replace( /(?:^|\s)descend(?!\S)/g, '' );
        th.className += ' ascend'
        return ascend;
    } else {
        th.className += ' ascend';
        return ascend;
    }
}
/**
 * Sort tables according chosen column
 * @param col   {number}           the chosen column
 *        table {HTMLTableElement} the chosen table
 *        way   {boolean}          the sortting way
 */
function sortColumn(col, table, way) {
    var rows = [].slice.call(table.getElementsByTagName('tbody')[0].getElementsByTagName('tr'));
    // extra the rows in a array

    var rows_th, rows_th_class;
    if (rows[0].getElementsByTagName('th').length != 0) {
        rows_th = rows[0];
        rows_th_class = rows[0].className;
        rows.splice(0, 1);
    }
    // for those whose don't have 'thead' tags

    rows.sort(function(row_a, row_b) {
        var col_a = row_a.getElementsByTagName('td')[col].innerHTML;
        var col_b = row_b.getElementsByTagName('td')[col].innerHTML;
        if (col_a > col_b) return 1;
        else if (col_a < col_b) return -1;
        else return 0;
    });

    if (!way) rows.reverse();
    
    var tbody = table.getElementsByTagName('tbody')[0];
    while (tbody.firstChild) {
        tbody.removeChild(tbody.firstChild);
    }

    if (rows_th) {
        rows_th.className = rows_th_class;
        tbody.appendChild(rows_th);
    };
    // for those whose don't have 'thead' tags

    for (var i = 0; i < rows.length; ++i) {
        tbody.appendChild(rows[i]);
    }
}
