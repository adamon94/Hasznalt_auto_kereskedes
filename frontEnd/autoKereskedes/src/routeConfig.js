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

    
    {
      path: "/cars/:id", name: "carDetails",
      component: import("./pages/car.vue"),
    },
    {
      path: "/registration",
      component: import("./pages/registrationPage.vue"),
    },
    {
      path: "/kedvencek",
      component: import("./pages/favorites.vue"),
    },
    
    {
      path: "/kivansaglista",
      component: import("./pages/wishes.vue"),
    },
    {
      path: "/teszt-vezetesek",
      component: import("./pages/testDrives.vue"),
    },
    {
      path: "/admin",
      component: import("./pages/administration.vue"),
    },
  ],
});

export default router;
