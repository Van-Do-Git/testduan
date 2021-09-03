let day = document.getElementById('day');
let formday = document.getElementById('formday');
let month = document.getElementById('month');
let formmonth = document.getElementById('formmonth');
let week = document.getElementById('week');
let formweek = document.getElementById('formweek');
let close = document.getElementsByClassName('close')[0];

day.onclick = function () {
    formday.style.display = "block";
    formweek.style.display = "none";
    formmonth.style.display = "none";

}

month.onclick = function () {
    formmonth.style.display = "block";
    formday.style.display = "none";
    formweek.style.display = "none"
}

week.onclick = function () {
    formweek.style.display = "block";
    formday.style.display = "none";
    formmonth.style.display = "none";
}

close.onclick = function () {
    formday.style.display = "none";
    formmonth.style.display = "none";
    formweek.style.display = "none"
}

window.onclick = function (event) {
    if (event.target == formday) {
        formday.style.display = "none";
    }
    if (event.target == formmonth) {
        formmonth.style.display = "none";
    }
    if (event.target == formweek) {
        formweek.style.display = "none"
    }
}