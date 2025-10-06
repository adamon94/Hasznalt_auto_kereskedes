<script setup>
import { useController } from "./stores/UIcontrol";
import { RouterView } from "vue-router";
import RegistrationModal from "./components/registrationModal.vue";
import LogModal from "./components/logModal.vue";
const useStore = useController()
const modalState = useStore.modalState
</script>

<template>
    <LogModal/>
    <RegistrationModal/>
    <router-view></router-view>
</template>

<style>

@import url("https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap");

*{
    box-sizing: border-box;
}

html,
body {
  scroll-behavior: smooth;
}

body {
  font-family: "Roboto", sans-serif;
}

</style>
