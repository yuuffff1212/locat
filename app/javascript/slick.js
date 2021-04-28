window.addEventListener('DOMContentLoaded', function (){
    // const $arrows = $('#arrow')
   $(function (){
       $('.top-wrapper').slick({
           autoplay:true,
           autoplaySpeed: 1800,
           draggable:true,
           centerMode: true,
           centerPadding: '25%',
           dots:false,
           arrows: false,
           focusOnSelect:true,
           variableWidth: true,
       });
   })
})