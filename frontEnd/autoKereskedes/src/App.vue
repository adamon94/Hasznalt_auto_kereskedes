<script setup>
import { useController } from "./stores/UIcontrol";
import { RouterView } from "vue-router";
import LogModal from "./components/logModal.vue";
import { onMounted } from "vue";
import Head from './components/Head.vue';

const store = useController();


onMounted(()=>{
  
  const isLogged = localStorage.getItem("isLogged")
  //const userId = localStorage.getItem("token")
  const token = localStorage.getItem("token")
  //const accessLevel = localStorage.getItem("accessLevel")
  if(isLogged){
    store.logIn()
  const tokenData = JSON.parse(token)
    
    // ✅ Then access the properties
    store.id = Number(tokenData.id)
    store.accessLevel = Number(tokenData.accessLevel)
    
  }
console.log(store.id)
console.log(store.accessLevel)
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
