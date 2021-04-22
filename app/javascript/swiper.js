window.addEventListener('DOMContentLoaded', function () {
    const swiper = new Swiper ('top-container' , {
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev,',
        },
        pagination: {
            el: '.swiper-pagination',
        },
        loop: true,
        effect: 'coverflow',
        autoplay: {
            delay: 2000,
            disableOnInteraction: false
        },

    })
})
//
//
//
//
