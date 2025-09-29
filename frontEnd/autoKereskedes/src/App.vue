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

*{
    box-sizing: border-box;
}

</style>
