import 'babel-polyfill'
import Vue from 'vue'

// 作成したコンポーネントファイルをimportします
<<<<<<< Updated upstream
import FavoriteButton from '../compenents/Favorite/FavoriteButton.vue'
=======
import FavoriteButton from '../components/Favorite/FavoriteButton'
>>>>>>> Stashed changes

document.addEventListener('DOMContentLoaded', () => {
    new Vue({
        el: '#favorite',
        components: { FavoriteButton }
    })
<<<<<<< Updated upstream
})
=======
})
>>>>>>> Stashed changes
