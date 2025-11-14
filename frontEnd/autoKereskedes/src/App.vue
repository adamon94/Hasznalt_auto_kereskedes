<script setup>
import { useController } from "./stores/UIcontrol";
import { RouterView } from "vue-router";
import LogModal from "./components/logModal.vue";
import { onMounted } from "vue";
import Head from './components/Head.vue';

const store = useController();


onMounted(()=>{
  document.title = "Auto Kereskedes"
  const isLogged = localStorage.getItem("isLogged")
  const userId = localStorage.getItem("token")
  if(isLogged){
    store.logIn()
    store.id = Number(JSON.parse(userId))
    console.log(store.id)
  }

})

</script>

<template>
    <LogModal/>
    <Head/>
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
