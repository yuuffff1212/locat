window.addEventListener('DOMContentLoaded', function (){
    $(function () {
        $('.menu-btn').click(function () {
            $(this).toggleClass('open');
            if($(this).hasClass('open')) {
                $('.menu').addClass('open');
            } else {
                $('.menu').removeClass('open')
            }
        })
    })
})

