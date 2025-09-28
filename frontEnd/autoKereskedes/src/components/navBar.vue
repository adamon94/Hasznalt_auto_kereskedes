<script setup>
import RegistrationModal from './registrationModal.vue';
import { useController } from '../stores/UIcontrol';
import { onMounted } from 'vue';

const useStore = useController();
const modalState = useStore.modalState

const showModal = ()=>{
    modalState = true
}
onMounted(()=>{
  console.log(useStore.modalState)
})

</script>


<template>


<nav class="navBar">

<ul class="menu">

<li>
    <div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle"
          type="button"
          data-bs-toggle="dropdown"
          aria-expanded="false"
  >
    Szolgáltatásaink
  </button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="#">Teszt vezetések</a></li>
    <li><a class="dropdown-item" href="#">Beszámítás</a></li>
    <li><a class="dropdown-item" href="#">Kedvező finanszírozás</a></li>
  </ul>
</div>  
</li>

<li>
<div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle"
          type="button"
          data-bs-toggle="dropdown"
          aria-expanded="false"
  >
    Kínálatunk
  </button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="#">Városi autóink</a></li>
    <li><a class="dropdown-item" href="#">Luxus autóink</a></li>
    <li><a class="dropdown-item" href="#">Terepjárók</a></li>
  </ul>
</div>

</li>
<li><button @click="useStore.showModal" class="navBtn">Regisztráció</button></li>
<li><button class="navBtn">Bejelentkezés</button></li>


</ul>

</nav>

</template>

<style scoped>

.navBar{
margin:auto;
width: 43%;
padding: 10px;
bottom: 33px;
left: 35%;

}

.menu{
    display: flex;
    list-style: none;
    justify-content: center ;
    align-items: center;
    margin-top: 20px;
    margin-left: 150px;
}
li{
    margin-right: 2rem;
    margin-top: 10px;
}
.navBtn{
    text-decoration: none;
    font-size: large;
    font-weight:bold;
    color: #536066;
    background-color: #C8BCCF;
    border: none;
    border-radius: 10px;
    padding:8px 25px;
}
</style>