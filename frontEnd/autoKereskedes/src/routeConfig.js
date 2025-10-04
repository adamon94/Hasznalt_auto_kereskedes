import { createWebHistory, createRouter } from "vue-router";

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: "/",
      component: import("./pages/home.vue"),
    },
    {
      path: "/cars",
      component: import("./pages/cars.vue"),
    },
    /*
    {
      path: "/link-employee",
      component: import("../pages/LinkEmployee.vue"),
    },
    {
      path: "/details/:id",
      component: import("../pages/Details.vue"),
    },*/
  ],
});

export default router;
