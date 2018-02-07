$(function() {
    $('.flash').each(function (index, el) {
        if($(el).context.innerText !== "") {
            $(el).delay(200).fadeIn('normal', function() {
                $(this).delay(5500).fadeOut();
            });
        }
    });
});