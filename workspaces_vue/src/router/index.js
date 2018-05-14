import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/pages/Home'
import NewWorkspace from '@/pages/NewWorkspace'
import MyWorkspace from '@/pages/MyWorkspace'
import SearchResult from '@/pages/SearchResult'
import DetailPage from '@/pages/DetailPage'
import CheckOrderPage from '@/pages/CheckOrder'
import AdminLogin from '@/pages/admin/Login'
import Dashboard from '@/pages/admin/Dashboard'
import AdminUser from '@/pages/admin/AdminUser'
import AdminWorkspace from '@/pages/admin/Workspace'
import AdminConvenient from '@/pages/admin/Convenient'
import AdminBanner from '@/pages/admin/Banner'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/new-workspace',
      name: 'NewWorkspace',
      component: NewWorkspace
    },
    {
      path: '/my-workspace',
      name: 'MyWorkspace',
      component: MyWorkspace
    },
    {
      path: '/search/:key',
      name: 'SearchResult',
      component: SearchResult
    },
    {
      path: '/:city/:name',
      name: 'DetailPage',
      component: DetailPage
    },
    {
      path: '/orders',
      name: 'CheckOrder',
      component: CheckOrderPage
    },
    {
      path: '/admin',
      name: 'AdminLogin',
      component: AdminLogin
    },
    {
      path: '/admin-dashboard',
      name: 'Dashboard',
      component: Dashboard
    },
    {
      path: '/admin-user',
      name: 'AdminUser',
      component: AdminUser
    },
    {
      path: '/admin-workspace',
      name: 'AdminWorkspace',
      component: AdminWorkspace
    },
    {
      path: '/admin-convenient',
      name: 'AdminConvenient',
      component: AdminConvenient
    },
    {
      path: '/admin-banner',
      name: 'AdminBanner',
      component: AdminBanner
    }
  ]
})
