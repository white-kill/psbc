import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
    {
        path: '/',
        component: () => import(/* webpackChunkName: "about" */ '../views/psbc/categoryChart.vue')
    },
    {
        path: '/psbc/categoryChart',
        name: 'psbc-categoryChart',
        component: () => import(/* webpackChunkName: "about" */ '../views/psbc/categoryChart.vue')
    },
    {
        path: '/psbc/anaysis',
        name: 'psbc-anaysis',
        component: () => import(/* webpackChunkName: "about" */ '../views/psbc/anaysis.vue')
    },
]

const router = new VueRouter({
    mode: 'hash',
    base: process.env.BASE_URL,
    routes
})

export default router
