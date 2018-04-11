// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import VueResource from 'vue-resource'
import router from './router'
import BootstrapVue from 'bootstrap-vue/dist/bootstrap-vue.esm'
import Vuex from 'vuex'
import { store } from './store/index'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import swal from 'sweetalert'
import GlobalConsts  from './constants/constant.js'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css'
import injector from 'vue-inject'
import VuePaginate from 'vue-paginate'

Vue.use(VuePaginate)
Vue.use(Vuex)
Vue.use(BootstrapVue)
Vue.use(GlobalConsts)

require('./services/injector-register.js');
Vue.use(injector)
Vue.use(ElementUI);
Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  store: store,
  el: '#app',
  created: function () {
   window.fbAsyncInit = function() {
    FB.init({
      appId      : '2068048373431539',
      cookie     : true,  // enable cookies to allow the server to access 
                          // the session
      xfbml      : true,  // parse social plugins on this page
      version    : 'v2.12' // use graph api version 2.8
    });
    window.FB.AppEvents.logPageView();
  };
  (function (d, s, id) {
    var js
    var fjs = d.getElementsByTagName(s)[0]
    if (d.getElementById(id)) return
      js = d.createElement(s)
      js.id = id
      js.src = 'https://connect.facebook.net/en_US/sdk.js'
      fjs.parentNode.insertBefore(js, fjs)
    }(document, 'script', 'facebook-jssdk'))
},
router,
components: { App },
template: '<App/>'
})
