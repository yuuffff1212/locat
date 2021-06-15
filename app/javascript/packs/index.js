import 'babel-polyfill'
import Vue from 'vue'

// 作成したコンポーネントファイルをimportします
import FavoriteButton from '../compenents/Favorite/FavoriteButton.vue'

document.addEventListener('DOMContentLoaded', () => {
    new Vue({
        el: '#favorite',
        components: { FavoriteButton }
    })
})
