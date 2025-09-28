<script setup>
import { useController } from "./stores/UIcontrol";
import { RouterView } from "vue-router";
import RegistrationModal from "./components/registrationModal.vue";
const useStore = useController()
const modalState = useStore.modalState
</script>

<template>
    <RegistrationModal/>
    <router-view></router-view>
</template>

<style>

*{
    box-sizing: border-box;
}

</style>
