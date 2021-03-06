import 'babel-polyfill'
import Vue from 'vue'

// 作成したコンポーネントファイルをimportします
import RelationshipButton from '../components/Relationship/RelationshipButton.vue'

document.addEventListener('DOMContentLoaded', () => {
    new Vue({
        el: '#relationship',
        components: { RelationshipButton }
    })
})
