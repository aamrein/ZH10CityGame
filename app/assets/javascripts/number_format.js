var currencyFormatter = new Intl.NumberFormat('de-CH', {
    style: 'currency',
    currency: 'USD'
});

var numberFormatter = new Intl.NumberFormat('de-CH', {'maximumSignificantDigits': 0});

var updateElements = function (className, formatter) {
    Array.from(document.getElementsByClassName(className))
        .forEach(function (element) {
            updateElement(element, formatter);
        })
};

var updateElement = function (element, formatter) {
    var value = formatter.format(element.innerHTML);
    if (value !== 'NaN') {
        element.innerHTML = value;
    }
};

var update = function () {
    updateElements("currency-format", currencyFormatter);
    updateElements("number-format", numberFormatter);
};

document.addEventListener("turbolinks:load", function() {
    update();
});