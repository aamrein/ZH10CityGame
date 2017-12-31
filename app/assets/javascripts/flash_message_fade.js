$(function() {
    $('.flash').each(function (index, el) {
        console.log($(el).context.innerText);
        if($(el).context.innerText !== "") {
            $(el).delay(200).fadeIn('normal', function() {
                $(this).delay(5500).fadeOut();
            });
        }
    });
});