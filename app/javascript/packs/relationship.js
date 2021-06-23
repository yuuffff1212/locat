import 'babel-polyfill'
import Vue from 'vue'

// 作成したコンポーネントファイルをimportします
import RelationshipButton from '../compenents/Refationship/RelationshipButton.vue'

document.addEventListener('DOMContentLoaded', () => {
    new Vue({
        el: '#relationship',
        components: { RelationshipButton }
    })
})
